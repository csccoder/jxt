package cn.jxt.bean;



import java.util.List;

public class PageHelper<T> {
    private int first=1;
    private int last;
    private int prePage;
    private int nextPage;
    private int count;
    private int curPage;
    private int pageSize;
    private List<T> data;

    public PageHelper() {
    }

    public PageHelper(int count, int curPage,int pageSize, List<T> data) {
        this.count = count;
        this.curPage = curPage;
        this.data = data;
        this.pageSize=pageSize;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getFirst() {
        return first;
    }

    public void setFirst(int first) {
        this.first = first;
    }

    public int getLast() {

        int sum=(int)Math.ceil(count*1.0/pageSize);

        return sum!=0?sum:first;
    }

    public void setLast(int last) {
        this.last = last;
    }

    public int getPrePage() {
       return curPage-1>0?curPage-1:first;
    }

    public void setPrePage(int prePage) {
        this.prePage = prePage;
    }

    public int getNextPage() {

        return curPage+1>getLast()?getLast():curPage+1;
    }

    public void setNextPage(int nextPage) {
        this.nextPage = nextPage;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public int getCurPage() {
        return curPage;
    }

    public void setCurPage(int curPage) {
        this.curPage = curPage;
    }

    public List<T> getData() {
        return data;
    }

    public void setData(List<T> data) {
        this.data = data;
    }

    @Override
    public String toString() {
        return "PageHelper{" +
                "first=" + first +
                ", last=" + last +
                ", prePage=" + prePage +
                ", nextPage=" + nextPage +
                ", count=" + count +
                ", curPage=" + curPage +
                ", pageSize=" + pageSize +

                '}';
    }


}
