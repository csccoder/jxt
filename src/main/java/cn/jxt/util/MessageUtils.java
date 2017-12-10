package cn.jxt.util;

import cn.jxt.bean.Guardian;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.*;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 发送短消息的工具类
 */
public class MessageUtils {
    /**
     * 根据输入流 通过WorkBookFactory解析各版本excel
     * @param inputStream
     * @return
     * @throws IOException
     * @throws InvalidFormatException 格式异常
     */
    public static Workbook getWorkBook(InputStream inputStream) throws IOException, InvalidFormatException {
        return WorkbookFactory.create(inputStream);

    }

    /**
     * 获取excel表的头单元格中值和列索引的映射
     * @param
     * @return
     */
    public static Map<String,Integer> getHeaderCellAtWorkBook(Sheet sheet){
        //获取第一行头单元格
        Row row=sheet.getRow(0);

        //获取当前行最后一个不为空的单元格的序号
        int lastCellNum=row.getLastCellNum();
        Map<String,Integer> map=new HashMap<String,Integer>();
        int i=0;
        Cell cell=null;
        while(i<lastCellNum){
            cell=row.getCell(i);
            map.put(cell.getStringCellValue(),i);
            i++;
        }

        return map;
    }

    /**
     * 利用excel中的数据解析短信模板，并返回真实的短信集合
     * @param content
     * @param inputStream
     * @return
     * @throws IOException
     * @throws InvalidFormatException
     */
    public static List<MessageWrap> resolveMessageContent( String content,  InputStream inputStream) throws IOException, InvalidFormatException,RuntimeException {
        Workbook workbook = getWorkBook(inputStream);
        Sheet sheet=workbook.getSheetAt(0);
        Map<String,Integer> headerCellNameColumnPairs=getHeaderCellAtWorkBook(sheet);

        List<PlaceholderColumnPair> placeholderColumnPairs=getPlaceholderColumnPair(content,headerCellNameColumnPairs);
        List<MessageWrap> messageWraps=new ArrayList<MessageWrap>();
        Row row=null;
        int lastRowNum=sheet.getLastRowNum();
        for( int rowIndex=1;rowIndex<=lastRowNum;rowIndex++){
            row=sheet.getRow(rowIndex);
            String realContent=content;
            for(PlaceholderColumnPair placeholderColumnPair:placeholderColumnPairs){
                String cellValue=null;
                cellValue=getCellValue(row,placeholderColumnPair.getColumn());
                realContent=realContent.replace(placeholderColumnPair.getPlaceholder(),cellValue);
            }
            String cellValueAt0=getCellValue(row,0);
            int childId=Integer.parseInt(cellValueAt0.contains(".")?cellValueAt0.substring(0, cellValueAt0.indexOf(".")):cellValueAt0);
            messageWraps.add(new MessageWrap(childId,realContent));
        }
        return messageWraps;
    }

    /**
     * 解析普通短信
     * @param studentIds
     * @param content
     * @return
     * @throws IOException
     * @throws InvalidFormatException
     * @throws RuntimeException
     */
    public static List<MessageWrap> resolveMessageContent(List<Integer> studentIds, String content) {
        List<MessageWrap> messageWraps=new ArrayList<MessageWrap>();
        MessageWrap messageWrap=null;
        for(Integer studentId:studentIds){
            messageWrap=new MessageWrap(studentId,content);
            messageWraps.add(messageWrap);
        }
        return messageWraps;
    }

    /**
     * 自动转换单元格值的类型为String，并返回String值
     * @param row
     * @param column
     * @return
     */
    private static String getCellValue(Row row,int column){
        String cellValue=null;
        int cellType=row.getCell(column).getCellType();
        if(cellType==Cell.CELL_TYPE_STRING){
            cellValue=row.getCell(column).getStringCellValue();
        }else if(cellType==Cell.CELL_TYPE_NUMERIC){
            cellValue=String.valueOf(row.getCell(column).getNumericCellValue());
        }
        return cellValue;
    }

    private static List<PlaceholderColumnPair> getPlaceholderColumnPair(String content,Map<String,Integer> headerCellNameColumnPairs) {
        String placeholderRegex="\\$\\{(.*?)\\}";
        Pattern pattern=Pattern.compile(placeholderRegex);
        Matcher matcher=pattern.matcher(content);
        List<PlaceholderColumnPair> placeholderColumnPairs=new  ArrayList<PlaceholderColumnPair>();
        String placeholder=null;
        String valueAtPlaceholder=null;
        Integer column;
        while(matcher.find()){
            placeholder=matcher.group();
            try{
                valueAtPlaceholder=matcher.group(1);
                column=Integer.parseInt(valueAtPlaceholder);
            }catch (NumberFormatException e){
                column=headerCellNameColumnPairs.get(valueAtPlaceholder);
                if(column==null){
                    throw new RuntimeException("占位符值错误，没有在excel头单元格找到"+valueAtPlaceholder+"对应的单元格");
                }
            }
            placeholderColumnPairs.add(new PlaceholderColumnPair(placeholder,column));

        }
        return placeholderColumnPairs;
    }

    /**
     * 消息的包装类
     */
    public static class MessageWrap{
        //消息的接受者
        private Guardian receiver;
        //消息接受者的孩子id
        private int childId;
        //消息实体
        private String content;

        public MessageWrap(int childId, String content) {
            this.childId=childId;
            this.content = content;
        }

        public int getChildId() {
            return childId;
        }

        public void setChildId(int childId) {
            this.childId = childId;
        }

        public Guardian getReceiver() {
            return receiver;
        }

        public void setReceiver(Guardian receiver) {
            this.receiver = receiver;
        }

        public String getContent() {
            return content;
        }

        public void setContent(String content) {
            this.content = content;
        }
    }
    /**
     * 占位符和列索引的键值对
     */
    static class PlaceholderColumnPair{
        private String placeholder;
        private int column;

        public PlaceholderColumnPair(String placeholder, int column) {
            this.placeholder = placeholder;
            this.column = column;
        }

        public String getPlaceholder() {
            return placeholder;
        }

        public void setPlaceholder(String placeholder) {
            this.placeholder = placeholder;
        }

        public int getColumn() {
            return column;
        }

        public void setColumn(int column) {
            this.column = column;
        }
    }
}
