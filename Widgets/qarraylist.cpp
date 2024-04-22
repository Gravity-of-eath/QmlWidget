#include "qarraylist.h"

QArrayList::QArrayList (QObject *parent) : QObject(parent) {
    m_list= QList<QVariant>();
}

void QArrayList::add(const QVariant &value)
{
    m_list.push_back(value);
    emit countChanged();
}
QVariant QArrayList::get(int index) const
{
    if(!m_list.isEmpty() && index < m_list.count()){
        return m_list.at(index);
    }
    return QVariant();
}
QVariant QArrayList::getTop() const
{
    if(m_list.isEmpty()){
        return QVariant();
    }
    return m_list.last();
}
int QArrayList::size() const
{
    return m_list.count();
}
void QArrayList::remove(int index)
{
    if(!m_list.isEmpty() && index < m_list.count()){
        m_list.removeAt(index);
    }
}
void QArrayList::pop()
{
    if(!m_list.isEmpty()){
        m_list.pop_back();
    }
}
void QArrayList::clear()
{
    if(!m_list.isEmpty()){
        m_list.clear();
    }
}
QArrayList::~QArrayList(){
//    if(m_list!=NULL){
//    delete(m_list);
//        m_list=NULL;
//    }
}
