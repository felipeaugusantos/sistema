{*************************************************}
{* CLASSE PARA CADASTRO DE COTAÇÕES DE MOEDAS    *}
{* (MANUTENÇÃO)                                  *}
{*                                               *}
{* DATA......: 24/11/2008                        *}
{* AUTOR.....: LUCIENE                           *}
{**********************************************LU*}
unit untCotacaoMoeda;

interface

uses Classes, StrUtils, SysUtils, Uni, UniClientDataSet, UniDataSetProvider, DB, Forms;

Type TCotMoe = Class(TComponent)
  Private
    FDtaMoe: String; // data da cotação
    FDolCom: Double; // valor dólar compra
    FDolVen: Double; // valor dólar venda
    FReaCom: Double; // valor real compra
    FReaVen: Double; // valor real venda
    FParCom: Double; // valor peso compra
    FParVen: Double; // valor peso venda
    FEurCom: Double; // valor euro compra
    FEurVen: Double; // valor euro venda
    FGuaCom: Double; // valor guaranie compra
    FGuaVen: Double; // valor guaranie venda
    FCodEmp: String; // empresa que cadastrou

    {**************************************}
    {* PROCEDURES E FUNÇÕES GERAIS        *}
    {***********************************LU*}
    procedure pAfterOpen(DataSet: TDataSet);

  Public
    qryCadMoe: TUniQuery;

    property strDtaMoe: String Read FDtaMoe Write FDtaMoe;
    property fltDolCom: Double Read FDolCom Write FDolCom;
    property fltDolVen: Double Read FDolVen Write FDolVen;
    property fltReaCom: Double Read FReaCom Write FReaCom;
    property fltReaVen: Double Read FReaVen Write FReaVen;
    property fltParCom: Double Read FParCom Write fParCom;
    property fltParVen: Double Read FParVen Write fParVen;
    property fltEurCom: Double Read FEurCom Write FEurCom;
    property fltEurVen: Double Read FEurVen Write FEurVen;
    property fltGuaCom: Double Read FGuaCom Write FGuaCom;
    property fltGuaVen: Double Read FGuaVen Write FGuaVen;
    property strCodEmp: String Read FCodEmp Write FCodEmp;

    Constructor Create(Owner: TComponent); Reintroduce;
  End;

implementation

uses untFuncoesSimples;

{ TCotMoe }

constructor TCotMoe.Create(Owner: TComponent);
begin
  qryCadMoe := fCriaQuery(Self);

  qryCadMoe.SQL.Add(' SELECT * FROM CADMOE WHERE FALSE ');

  qryCadMoe.AfterOpen := pAfterOpen;
end;

procedure TCotMoe.pAfterOpen(DataSet: TDataSet);
begin

  With DataSet Do
  Begin
    (FieldByName('MOE_DTAMOE') As TDateTimeField).DisplayFormat := 'dd/mm/yyyy';
    (FieldByName('MOE_DTAMOE') As TDateTimeField).EditMask      := '!99/99/9999;1;_';

    (FieldByName('MOE_DOLCOM') As TFloatField).DisplayFormat := '#,##0.0000';
    (FieldByName('MOE_DOLCOM') As TFloatField).EditFormat    := '###0.0000';

    (FieldByName('MOE_DOLVEN') As TFloatField).DisplayFormat := '#,##0.0000';
    (FieldByName('MOE_DOLVEN') As TFloatField).EditFormat    := '###0.0000';

    (FieldByName('MOE_REACOM') As TFloatField).DisplayFormat := '#,##0.0000';
    (FieldByName('MOE_REACOM') As TFloatField).EditFormat    := '###0.0000';

    (FieldByName('MOE_REAVEN') As TFloatField).DisplayFormat := '#,##0.0000';
    (FieldByName('MOE_REAVEN') As TFloatField).EditFormat    := '###0.0000';

    (FieldByName('MOE_PARCOM') As TFloatField).DisplayFormat := '#,##0.0000';
    (FieldByName('MOE_PARCOM') As TFloatField).EditFormat    := '###0.0000';

    (FieldByName('MOE_PARVEN') As TFloatField).DisplayFormat := '#,##0.0000';
    (FieldByName('MOE_PARVEN') As TFloatField).EditFormat    := '###0.0000';

    (FieldByName('MOE_EURCOM') As TFloatField).DisplayFormat := '#,##0.0000';
    (FieldByName('MOE_EURCOM') As TFloatField).EditFormat    := '###0.0000';

    (FieldByName('MOE_EURVEN') As TFloatField).DisplayFormat := '#,##0.0000';
    (FieldByName('MOE_EURVEN') As TFloatField).EditFormat    := '###0.0000';

    (FieldByName('MOE_GUACOM') As TFloatField).DisplayFormat := '#,##0.0000';
    (FieldByName('MOE_GUACOM') As TFloatField).EditFormat    := '###0.0000';

    (FieldByName('MOE_GUAVEN') As TFloatField).DisplayFormat := '#,##0.0000';
    (FieldByName('MOE_GUAVEN') As TFloatField).EditFormat    := '###0.0000';
  End;

end;

end.
