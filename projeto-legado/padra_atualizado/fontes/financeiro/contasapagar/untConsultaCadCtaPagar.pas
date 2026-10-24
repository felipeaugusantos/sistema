unit untConsultaCadCtaPagar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, DB,  
  Uni, ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids, DBGridCitel, DBGrids,
  BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCadCtaPagar = class(TfrmConsultaComp)
    pnlAuxiliar: TPanel;
    btnDupAgr: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnDupAgrClick(Sender: TObject);
    procedure qryConsultaAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    procedure pMostraDuplicatasAgrupadas(strNumAgr, strCodEmp: String);
  protected
    procedure pAtuIndice(intIndice: Integer); override;
  public
    { Public declarations }
  end;

var
  frmConsultaCadCtaPagar: TfrmConsultaCadCtaPagar;

implementation

uses untCtpMostraAgrupadas, untConstantes, untFuncoesSimples, StrUtils;

{$R *.dfm}

procedure TfrmConsultaCadCtaPagar.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F9: btnDupAgr.Click;
  End;

end;

procedure TfrmConsultaCadCtaPagar.pAtuIndice(intIndice: Integer);
begin
  inherited;

  btnDupAgr.Visible := LeftStr(qryConsulta.FieldByName('Duplicata').AsString,2) = 'AG';

end;

procedure TfrmConsultaCadCtaPagar.btnDupAgrClick(Sender: TObject);
begin
  inherited;

  With qryConsulta Do
  If LeftStr(FieldByName('Duplicata').AsString,2) = 'AG' Then
  Begin
    pMostraDuplicatasAgrupadas(FieldByName('Duplicata').AsString, FieldByName('Empresa').AsString);
  End;

end;

procedure TfrmConsultaCadCtaPagar.qryConsultaAfterScroll(
  DataSet: TDataSet);
begin
  inherited;

  btnDupAgr.Visible := LeftStr(qryConsulta.FieldByName('Duplicata').AsString,2) = 'AG';

end;

procedure TfrmConsultaCadCtaPagar.pMostraDuplicatasAgrupadas(strNumAgr, strCodEmp: String);
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CTP_NUMDUP AS NUMDUP, ';
  strSQL := strSQL + '   CTP_PARCEL AS PARCEL, ';
  strSQL := strSQL + '   CTP_CODEMP AS CODEMP, ';
  strSQL := strSQL + '   CTP_SERIE_ AS SERIE_, ';
  strSQL := strSQL + '   CTP_DTAVEN AS DTAVEN, ';
  strSQL := strSQL + '   CTP_VALORI AS VALORI  ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL +     String(ARRDUPAGP[intCaixa]);
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   CTP_NUMAGR = :NUMAGR AND ';
  strSQL := strSQL + '   CTP_EMPAGR = :EMPAGR ';

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMAGR').AsString := strNumAgr;
    ParamByName('EMPAGR').AsString := strCodEmp;
    Open;

    Try
      pCriarFormularios(TfrmCtpMostraAgrupadas, frmCtpMostraAgrupadas);
      frmCtpMostraAgrupadas.Caption := frmCtpMostraAgrupadas.Caption + ' - ' + strNumAgr + '-' + strCodEmp;
      frmCtpMostraAgrupadas.dtsDupAgr.DataSet := qryGen;

      (FieldByName('VALORI') As TFloatField).DisplayFormat := '#,##0.00';

      frmCtpMostraAgrupadas.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[pMostraDuplicatasAgrupadas]');
      End;
    End;

    pFreeAndNil(frmCtpMostraAgrupadas);
    Close;

  End;

  FreeAndNil(qryGen);
end;


end.
