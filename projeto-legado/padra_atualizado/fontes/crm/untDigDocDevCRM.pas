unit untDigDocDevCRM;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms, 
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons, Uni,
  ExtCtrls, Mask, MaskEditFocus, AppEvnts, EditFocus, StrUtils,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, QColorLabel, Data.Db;

type
  TfrmDigDocDevCRM = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    pnlNumDoc: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    ColorLabel3: TColorLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    edtCodEmp: TEditFocus;
    edtDesMot: TEditFocus;
    edtCodMot: TEditFocus;
    edtGarant: TEditFocus;
    procedure btnCancelaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodMotKeyPress(Sender: TObject; var Key: Char);
  private
    qryCadMot: TUniQuery;
    function fDocumentoExiste(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;
    procedure pCarregaOcorrencia;
    function fValidaPrazoDeDevolucao: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    strCodCli: String;
    strCodEmp: String;
    qryItens : TUniQuery;
  end;

var
  frmDigDocDevCRM: TfrmDigDocDevCRM;

implementation

uses untfuncoesSimples, untConsultas, untTypesSistema, untFatVendas,
  untFuncoesCRM, untConstantes, untPesqAux;

{$R *.dfm}

procedure TfrmDigDocDevCRM.btnCancelaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TfrmDigDocDevCRM.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumDoc) Then
    Begin
      If fEmptyStr(edtNumDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o número do documento!', ['&OK']);
        Result := False;
      End
    End

    Else If Sender = edtEspDoc Then
    Begin
      If fEmptyStr(edtEspDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe a espécie do documento!', ['&OK']);
        Result := False;
      End
      Else If (Not fDocumentoExiste(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, strCodCli)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Documento de venda informado não existe!', ['&OK']);
        Result := False;
      End
      Else If (Not fValidaPrazoDeDevolucao) Then
      Begin
        fMensagem('ATENÇÃO', 'Data do documento ultrapassa a quantidade de dias configurada em CFG_DIADEV. A devolução não será permitida!', ['OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodMot) Then
    Begin

      If fEmptyStr(edtCodMot.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Motivo deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaOcorrencia;
        If qryCadMot.FieldByName('OCO_CODOCO').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Motivo não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtGarant) Then
    Begin
      If fEmptyStr(edtGarant.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'É obrigatório o preenchimento do campo Garantia S ou N!', ['&O k']);
        Result := False;
      End
      Else If (Pos('S',edtGarant.Text) <= 0) And (Pos('N',edtGarant.Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'É obrigatório o preenchimento do campo Garantia S ou N !', ['&O k']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmDigDocDevCRM.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma  := False;
  strCodEmp    := VS_strCodEmp;
  qryItens     := fCriaQuery(Self);
  qryCadMot    := fCriarQuery('SELECT * FROM CADOCO WHERE FALSE', Self);
end;

procedure TfrmDigDocDevCRM.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    blnConfirma := True;
    Close;
  End;
end;

procedure TfrmDigDocDevCRM.FormShow(Sender: TObject);
begin
  inherited;
  edtNumDoc.TamCampo  := fTamDocCadRec;
  edtNumDoc.MaxLength := edtNumDoc.TamCampo;

  edtCodEmp.Text    := strCodEmp;
  edtCodEmp.Enabled := False;
end;

procedure TfrmDigDocDevCRM.edtCodMotKeyPress(Sender: TObject; var Key: Char);
  Var
    arrOcor: TConsultasArray;
begin
  inherited;
  If fPesqOcorrencia(Self, edtCodMot, edtDesMot, Nil, Key, arrOcor) Then
  begin
    If fValidaCampos(edtCodMot, True) Then
      Self.SelectNext(ActiveControl, True, True);
  end;
end;

function TfrmDigDocDevCRM.fDocumentoExiste(strNumDoc, strEspDoc,
  strCodEmp, strCodCli: String): Boolean;
  Const
    CONF_CUPOM_MOVDET = ' OR ((SELECT COUNT(*) FROM NOTDET DES   '+
                        'WHERE DES.DET_NUMDOC = D.DET_NUMFAT AND '+
                        '      DES.DET_ESPDOC = D.DET_TIPFAT AND '+
                        '      DES.DET_CODEMP = D.DET_EMPFAT AND '+
                        '      DES.DET_ESPDOC = "NF" AND         '+
                        '        D.DET_ESPDOC = "IF") > 0)       ';
    CONF_CUPOM_NOTDET = 'AND ((SELECT COUNT(*) FROM MOVDET ORI   '+
                        'WHERE D.DET_NUMDOC = ORI.DET_NUMFAT AND '+
                        '      D.DET_ESPDOC = ORI.DET_TIPFAT AND '+
                        '      D.DET_CODEMP = ORI.DET_EMPFAT AND '+
                        '      D.DET_ESPDOC = "NF" AND           '+
                        '    ORI.DET_ESPDOC = "IF") = 0)         ';
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  D.AUTOINCREM AS SEQORI,                         ';
  strSQL := strSQL + '  DET_DTAENT, DET_NUMDOC, DET_ESPDOC, DET_CODEMP, ';
  strSQL := strSQL + '  DET_CODCLI, DET_TIP_FC, DET_SERIE_, ';
  strSQL := strSQL + '  DATEDIFF(CURRENT_DATE, DET_DTAENT) AS DIADEV, ';
  strSQL := strSQL + '  DET_CODITE,  ';
  strSQL := strSQL + '  SUM(DET_QTDITE) - ';
  strSQL := strSQL + '  (SELECT IFNULL(SUM(DET_QTDITE),0) AS DEV ';
  strSQL := strSQL + '       FROM                                ';
  strSQL := strSQL + '         MOVDET DET                        ';
  strSQL := strSQL + '       WHERE DET.DET_CODITE = D.DET_CODITE ';
  strSQL := strSQL + '         AND DET.DET_DOCDEV = D.DET_NUMDOC     ';
  strSQL := strSQL + '         AND DET.DET_ESPDEV = D.DET_ESPDOC     ';
  strSQL := strSQL + '         AND DET.DET_EMPDEV = D.DET_CODEMP     ';
  strSQL := strSQL + '   ) AS DET_QTDITE,                            ';
  strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0, (D.DET_TOTITE - D.DET_DESESP) / D.DET_QTDITE) AS "DET_UNITAR"  ';
  strSQL := strSQL + 'FROM <<SQL_TABDET>> D ';
  strSQL := strSQL + '  INNER JOIN CADITE I ON D.DET_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '  INNER JOIN CADCLI C ON C.CLI_CODCLI = D.DET_CODCLI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  (D.DET_JAFATU = 0 <<SQL_CONF_CUPOM>>) AND ';
  strSQL := strSQL + '  D.DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
  strSQL := strSQL + '  D.DET_TIP_FC = "C"          AND ';
  strSQL := strSQL + '  D.DET_ORIDOC = "V"          AND ';
  strSQL := strSQL + '  D.DET_ESPDOC IN ("NF", "MI", "FF", "IF", "IV") AND ';
  strSQL := strSQL + '  IFNULL(D.DET_PROEMB, "N") <> "S" AND ';
  strSQL := strSQL + '  D.DET_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '  D.DET_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  D.DET_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  D.DET_ESPDOC = :ESPDOC AND ';

  strSQL := strSQL + '  ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR ' +
                     '   (LOCATE(DET_CLAFIS, :CLADEV) > 0) OR ' +
                     '   (DET_ESPDOC = "ML" AND DET_ORIDOC="V") ';

  If (fCfgSis('DVBRAD', varBoolean)) Then
    strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
  Else
    strSQL := strSQL + ') ';

  strSQL := strSQL + ' GROUP BY                                  ';
  strSQL := strSQL + '  D.DET_CODITE, D.DET_UNITAR, D.AUTOINCREM ';
  strSQL := strSQL + ' HAVING DET_QTDITE > 0                     ';

  With qryItens Do
  Begin
    Close;
    SQL.Text := AnsiReplaceStr(AnsiReplaceStr(strSQL, '<<SQL_TABDET>>', 'MOVDET'), '<<SQL_CONF_CUPOM>>', CONF_CUPOM_MOVDET);
    ParamByName('CODCLI').AsString := strCodCli;
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CLAFIS').AsString := VS_strClaVen;
    ParamByName('CLADEV').AsString := VS_strClaDev;
    Open;
    Result := Not IsEmpty;

    If Not Result Then
    Begin
      Close;
      SQL.Text := AnsiReplaceStr(AnsiReplaceStr(strSQL, '<<SQL_TABDET>>', 'NOTDET'), '<<SQL_CONF_CUPOM>>', CONF_CUPOM_NOTDET);
      Open;

      Result := Not IsEmpty;
    End;
  End;

end;

procedure TfrmDigDocDevCRM.pCarregaOcorrencia;
begin
  pPesquisaCadOco(Nil, qryCadMot, edtCodMot.Text);
  With qryCadMot Do
  Begin
    edtDesMot.Text := FieldByName('OCO_DESOCO').AsString;
  End;
end;

function TfrmDigDocDevCRM.fValidaPrazoDeDevolucao: Boolean;
  Var
    intDias: Integer;
begin
  Result := False;
  intDias := fCfgSis('DIADEV', varInteger);

  If (intDias > 0) And (qryItens.FieldByName('DIADEV').AsInteger > intDias) Then
    Exit;

  Result := True;
end;

End.


