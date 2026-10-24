unit untDigCtaFornecedores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, cxDBLookupComboBox,
  untFuncoesSimples, untTypesSistema, untZClient, Uni, MemDS, DBAccess,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmDigCtaFornecedores = class(TfrmPaiConfirma)
    cxgFornecLevel1: TcxGridLevel;
    cxgFornec: TcxGridCitel;
    cxvFornec: TcxGridDBTableViewCitel;
    cxvFornecCODFOR: TcxGridDBColumn;
    cxvFornecNOMFOR: TcxGridDBColumn;
    cxvFornecCODCTA: TcxGridDBColumn;
    dtsCodCta: TDataSource;
    cxvFornecDESCTA: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxvFornecCODCTAGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
  private
    { Private declarations }
    cdsCodFor: TZClient;

    qryCadCta: TUniQuery;

    Function fSQLFornedecores: String;
    Function fSQLCadCta: String;
    Function fVerificaCodCta: Boolean;

    Procedure pAfterScrollFornec(DataSet: TDataSet);
    Procedure pBeforePostFornec(DataSet: TDataSet);

    procedure pFilterRecordCadCta(DataSet: TDataSet; var Accept: Boolean);


  public
    { Public declarations }

    ArrCodCta: TarrCodCtaFornec;

    Class Procedure pCopiaCta(ArrCodCtaOri: TarrCodCtaFornec; Var ArrCodCtaDes: TarrCodCtaFornec);

  end;

var
  frmDigCtaFornecedores: TfrmDigCtaFornecedores;

implementation

{$R *.dfm}

Procedure TfrmDigCtaFornecedores.pAfterScrollFornec(DataSet: TDataSet);
Begin
  qryCadCta.Filtered := False;
  qryCadCta.Filtered := True;
End;

Procedure TfrmDigCtaFornecedores.pBeforePostFornec(DataSet: TDataSet);
Begin
  With DataSet Do
  FieldbyName('DESCTA').AsString := fRetDescCentroCusto(FieldbyName('CODCTA').AsString);
End;

procedure TfrmDigCtaFornecedores.pFilterRecordCadCta(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := Pos(cdsCodFor.FieldByName('CODFOR').AsString, DataSet.FieldByName('CODFOR').AsString) > 0;
end;

Function TfrmDigCtaFornecedores.fSQLFornedecores: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   FOR_CODFOR AS CODFOR, ';
  strSQL := strSQL + '   FOR_NOMFOR AS NOMFOR, ';
  strSQL := strSQL + '   (SELECT CTA_CODCTA FROM CADCTA WHERE FALSE) AS CODCTA,  ';
  strSQL := strSQL + '   (SELECT CTA_DESCTA FROM CADCTA WHERE FALSE) AS DESCTA   ';

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADFOR ';
  strSQL := strSQL + ' WHERE FALSE ';

  Result := strSQL;
End;

procedure TfrmDigCtaFornecedores.cxvFornecCODCTAGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;

  If Not VarIsNull(ARecord.Values[cxvFornecCODCTA.Index]) then
    AText := fFormataCCusto(ARecord.Values[cxvFornecCODCTA.Index]) + ' - '+ ARecord.Values[cxvFornecDESCTA.Index];

end;

procedure TfrmDigCtaFornecedores.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin

    If Not fVerificaCodCta Then
    Begin
      Action := caNone;
    End;

  End;


end;

procedure TfrmDigCtaFornecedores.FormShow(Sender: TObject);
  Var
    intContador: Integer;
begin
  inherited;

  qryCadCta := fCriaQuery(Self);

  qryCadCta.SQL.Text := fSQLCadCta;
  qryCadCta.Open;

  cdsCodFor := TZClient.Create(Self, fSQLFornedecores);
  cdsCodFor.fAbreClient(True, 'TfrmDigCtaFornecedores.FormCreate');
  cdsCodFor.IndexFieldNames := 'CODFOR';

  cdsCodFor.BeforePost := pBeforePostFornec;

  cdsCodFor.pAlinhaCampoCentro('CODFOR');

  For intContador := Low(arrCodCta) To High(arrCodCta) Do
  Begin
    cdsCodFor.Insert;
    cdsCodFor.FieldByName('CODFOR').AsString := arrCodCta[intContador].strCodFor;
    cdsCodFor.FieldByName('CODCTA').AsString := arrCodCta[intContador].strCodCta;

    cdsCodFor.FieldByName('NOMFOR').AsString := fRetNomFornecedor(arrCodCta[intContador].strCodFor);

    cdsCodFor.Post;
  End;

  qryCadCta.OnFilterRecord := pFilterRecordCadCta;

  cdsCodFor.AfterScroll := pAfterScrollFornec;

  cxvFornec.DataController.DataSource := cdsCodFor.dtsSource;

  dtsCodCta.DataSet := qryCadCta;
end;

Function TfrmDigCtaFornecedores.fSQLCadCta: String;
  Var
    strSQL: String;
    stlCodFor: TStringList;
    intContador: Integer;
Begin
  stlCodFor := TStringList.Create;

  For intContador := Low(arrCodCta) To High(arrCodCta) Do
    stlCodFor.Add(arrCodCta[intContador].strCodFor);

  strSQL := '';
  strSQL := strSQL + ' SELECT   ';
  strSQL := strSQL + '   CTA_CODCTA AS CODCTA, ';
  strSQL := strSQL + '   CONCAT(CTA_CODCTA, " - ", CTA_DESCTA) AS DESCTA, ';
  strSQL := strSQL + '   GROUP_CONCAT(FOR_CODFOR) AS CODFOR ';
  strSQL := strSQL + ' FROM     ';
  strSQL := strSQL + '   CADFOR ';

  strSQL := strSQL + ' INNER JOIN CTAFOR ON CTF_CODFOR = FOR_CODFOR ';
  strSQL := strSQL + ' INNER JOIN CADCTA ON CTA_CODCTA = CTF_CODCTA ';

  strSQL := strSQL + ' WHERE    ';
  strSQL := strSQL + '   FOR_CODFOR IN (' +  fCommaText(stlCodFor, True) + ')';

  strSQL := strSQL + ' GROUP BY CTA_CODCTA ';

  Result := strSQL;

  FreeAndNil(stlCodFor);
End;

Class Procedure TfrmDigCtaFornecedores.pCopiaCta(ArrCodCtaOri: TarrCodCtaFornec;
                                           Var ArrCodCtaDes: TarrCodCtaFornec);
  Var
    intContador: Integer;
Begin
  SetLength(arrCodCtaDes, Length(arrCodCtaOri));

  For intContador := Low(arrCodCtaDes) To High(arrCodCtaDes) Do
  Begin
    arrCodCtaDes[intContador].strCodFor := arrCodCtaOri[intContador].strCodFor;
    arrCodCtaDes[intContador].strCodCta := arrCodCtaOri[intContador].strCodCta;
  End;
End;

Function TfrmDigCtaFornecedores.fVerificaCodCta: Boolean;
  Var
    intContador: Integer;
Begin
  Result := True;

  For intContador := Low(arrCodCta) To High(arrCodCta) Do
    If cdsCodFor.FindKey([arrCodCta[intContador].strCodFor]) Then
      arrCodCta[intContador].strCodCta := cdsCodFor.FieldByName('CODCTA').AsString;

  For intContador := Low(arrCodCta) To High(arrCodCta) Do
    If fEmptyStr(arrCodCta[intContador].strCodCta) Then
    Begin
      pMensagemOk('Informe o Plano de Contas para o fornecedor ' + arrCodCta[intContador].strCodFor + '!');
      Result := False;
      Exit;
    End;

End;

end.
