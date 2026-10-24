unit untFatDigDadosNFComplValor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, StdCtrls, EditFocus, AppEvnts, Menus, ComCtrls,
  Buttons, BitBtnLockedIncrem, ExtCtrls, Uni, untFuncFat, Mask,
  MaskEditFocus, frxClass, frxExportCSVTestabilidade, untTypesSistema;

type
  TfrmFatDigDadosNfComplValor = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    Label1: TLabel;
    grbDFe: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    lblEspecie: TLabel;
    edtChaveAcesso: TEditFocus;
    edtEspDoc: TEditFocus;
    edtNumDoc: TEditFocus;
    edtSerie: TEditFocus;
    Label2: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label3: TLabel;
    mskDtaFin: TMaskEditFocus;
    lblDtaIni: TLabel;
    procedure edtNumDocKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure edtNumDocEnter(Sender: TObject);
    procedure edtNumDocExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure pCarregaDoc;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    blnCupomIPI: Boolean;
    blnConfirma: Boolean;
    blnDocFor  : Boolean;
    strCodFaz  : String;
    strCodCli  : String;
  end;

var
  frmFatDigDadosNfComplValor: TfrmFatDigDadosNfComplValor;

implementation

uses untFuncoesSimples, untConsultas;

{$R *.dfm}

{ TfrmFatDigDadosNfComplValor }

procedure TfrmFatDigDadosNfComplValor.btnCancelaDadosClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatDigDadosNfComplValor.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  If (fVerificaCampos) Then
  Begin
    blnConfirma := True;
    Close;
  End;

end;

procedure TfrmFatDigDadosNfComplValor.edtNumDocEnter(Sender: TObject);
var
  key: Char;
begin
  inherited;

  If (Not fValidaCampos(mskDtaIni, True)) Or
     (Not fValidaCampos(mskDtaFin, True)) Then
    Exit;

  key := '?';
  edtNumDocKeyPress(edtNumDoc,key);
end;

procedure TfrmFatDigDadosNfComplValor.edtNumDocExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmFatDigDadosNfComplValor.edtNumDocKeyPress(Sender: TObject;
  var Key: Char);
Var
  qryGen: TUniQuery;
  arrSel: TConsultasArray;
begin
  inherited;

  Try
    qryGen :=  fCriaQuery(Self);

    If fPesqLivroFiscal(Self, qryGen, Key, arrSel, True, conNotaComplemento, IIF(blnDocFor, 'F', 'C'), strCodCli, strCodFaz, '', False, strToDateDef(mskDtaIni.Text, 0), strToDateDef(mskDtaFin.Text, 0), True, '', False, True) Then
    Begin
      edtNumDoc.Text      := qryGen.FieldByName('FIS_NUMDOC').AsString;
      edtChaveAcesso.Text := qryGen.FieldByName('FIS_ACESSO').AsString;
      edtSerie.Text       := qryGen.FieldByName('FIS_SERIE_').AsString;
      edtEspDoc.Text      := qryGen.FieldByName('FIS_ESPDOC').AsString;

      SelectNext(ActiveControl, True, True);
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmFatDigDadosNfComplValor.edtNumDocKeyPress]');
  End;

  FreeAndNil(qryGen);
end;

procedure TfrmFatDigDadosNfComplValor.FormActivate(Sender: TObject);
begin
  inherited;
  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy', VS_DATE - 30);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy', VS_DATE);
  pSetFocus(mskDtaIni);
end;

procedure TfrmFatDigDadosNfComplValor.FormCreate(Sender: TObject);
begin
  inherited;
  blnCupomIPI := False;
  blnConfirma := False;
  blnDocFor   := False;
  strCodCli   := '';
end;

procedure TfrmFatDigDadosNfComplValor.FormShow(Sender: TObject);
begin
  inherited;
  grbDFe.Visible := not blnCupomIPI;
end;

function TfrmFatDigDadosNfComplValor.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = mskDtaFin) Then
    Begin
      If (fEmptyDate(mskDtaIni.Text)) And (Not fEmptyDate(mskDtaFin.Text))  Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial deve ser preenchida!', ['&O k']);
        Sender := mskDtaIni;
        Result := False;
      End

      Else If (Not fEmptyDate(mskDtaIni.Text)) And (fEmptyDate(mskDtaFin.Text))  Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
        Result := False;
      End

      Else If (Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
        Sender := MskDtaIni;
        Result := False;
      End;
    End

    Else If grbDFe.Visible And ((Sender = edtNumDoc) Or (Sender = edtSerie) Or (Sender = edtEspDoc)) Then
    Begin

      If fEmptyStr(edtNumDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'A nota de referência deve ser preenchida!', ['OK']);
        Result := False;
      End
      Else If fEmptyStr(edtEspDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'A espécie de referência deve ser preenchida!', ['OK']);
        Result := False;
      End
      Else If Pos(edtEspDoc.Text, 'NF_EL_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'A espécie de referência deve ser NF ou EL!', ['OK']);
        Result := False;
      End
      Else If fEmptyStr(edtSerie.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'A série de referência deve ser preenchida!', ['OK']);
        Result := False;
      End
      Else If (edtNumDoc.Text <> '') And (edtSerie.Text <> '') And (edtEspDoc.Text <> '') Then
      Begin
        pCarregaDoc;

        If (fEmptyStr(edtNumDoc.Text)) Or (fEmptyStr(edtSerie.Text)) Or (fEmptyStr(edtEspDoc.Text)) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'Documento não encontrado!', ['OK']) = -1;
        End
        Else If (fEmptyStr(edtChaveAcesso.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'Documento não permitido, pois não possui chave de acesso!', ['OK']);
          Result := False;
        End;
      End;

    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmFatDigDadosNfComplValor.pCarregaDoc;
Var
  qryGen: TUniQuery;
begin

  Try

    qryGen := fCriaQuery(Self);

    If (Not fEmptyStr(edtNumDoc.Text)) And (Not fEmptyStr(edtSerie.Text)) And (Not fEmptyStr(edtEspDoc.Text)) Then
    Begin
      qryGen.SQL.Clear;

      qryGen.SQL.Add(' SELECT DISTINCT ');
      qryGen.SQL.Add('   FIS_NUMDOC, ');
      qryGen.SQL.Add('   FIS_ESPDOC, ');
      qryGen.SQL.Add('   FIS_SERIE_, ');
      qryGen.SQL.Add('   FIS_DTADOC, ');
      qryGen.SQL.Add('   FIS_ACESSO, ');
      qryGen.SQL.Add('   FIS_ENTSAI, ');
      qryGen.SQL.Add('   AUTOINCREM ');
      qryGen.SQL.Add(' FROM CADFIS ');
      qryGen.SQL.Add(' WHERE TRUE ');
      qryGen.SQL.Add('     AND FIS_ESPDOC = :ESPDOC ');
      qryGen.SQL.Add('     AND FIS_ORIDOC = "V" ');

      If blnDocFor Then
        qryGen.SQL.Add('     AND FIS_TIP_FC = "F" ')
      Else
        qryGen.SQL.Add('     AND FIS_TIP_FC = "C" ');

      qryGen.SQL.Add('     AND FIS_FORCLI = ' + QuotedStr(strCodCli));
      qryGen.SQL.Add('     AND FIS_CODEMP = ' + AnsiQuotedStr(VS_strCodEmp, '"'));
      qryGen.SQL.Add('     AND FIS_NUMDOC = :NUMDOC ');
      qryGen.SQL.Add('     AND IFNULL(FIS_SERIE_, "") = :SERIE ');

      qryGen.ParamByName('NUMDOC').AsString := edtNumDoc.Text;
      qryGen.ParamByName('ESPDOC').AsString := edtEspDoc.Text;
      qryGen.ParamByName('SERIE').AsString  := edtSerie.Text;
      qryGen.Open;

      edtNumDoc.Text := qrygen.FieldByName('FIS_NUMDOC').AsString;
      edtChaveAcesso.Text := qrygen.FieldByName('FIS_ACESSO').AsString;
      edtSerie.Text := qrygen.FieldByName('FIS_SERIE_').AsString;

    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmFatDigDadosNfComplValor.pCarregaDoc]');
  End;

  FreeAndNil(qryGen);

end;

end.
