#include "qarraylist.h"

QArrayList::QArrayList (QObject *parent) : QObject(parent) {
    m_list= QList<QVariant>();
}

void QArrayList::add(const QVariant &value)
{
    m_list.append(value);
    emit countChanged();
}
QVariant QArrayList::get(int index) const
{
    return m_list.at(index);
}
int QArrayList::size() const
{
    return m_list.count();
}
void QArrayList::remove(int index)
{
    return m_list.removeAt(index);
}
void QArrayList::pop()
{
    return m_list.removeLast();
}
QArrayList::~QArrayList(){
//    if(m_list!=NULL){
//    delete(m_list);
//        m_list=NULL;
//    }
}
