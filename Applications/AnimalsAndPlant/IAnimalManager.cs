namespace DongThucVatQuangTri.Applications.Animals
{
    public interface IAnimalManager<T>
    {
        public List<T> GetAllList();
        public List<T> GetItemById(int id);
    }
}
