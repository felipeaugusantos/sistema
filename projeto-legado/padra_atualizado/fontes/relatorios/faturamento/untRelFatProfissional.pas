unit untRelFatProfissional;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, Mask, MaskEditFocus, RLFilters, RLDraftFilter,
  Menus, StdCtrls, EditFocus, QColorLabel, Buttons, ExtCtrls, StrUtils,
  frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, frxExportTXT, Uni, AppEvnts;

type
  TfrmRelFatProfissional = class(TfrmPaiRelatorio)
    Label11: TLabel;
    lblDesDtaIni: TLabel;
    lblDesDtaFin: TLabel;
    Label12: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label1: TLabel;
    edtCodProfissional: TEditFocus;
    edtDesProfissional: TEditFocus;
    gpbTipo: TGroupBox;
    ColorLabel2: TColorLabel;
    edtTipo: TEditFocus;
    lstClaFis: TMemo;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodProfissionalExit(Sender: TObject);
    procedure edtCodProfissionalKeyPress(Sender: TObject; var Key: Char);

    procedure pCarregaProfissional(Var qryCadDiv: TUniQuery);
    procedure pAtualizaClaFis;
    procedure btnImprimirClick(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmRelFatProfissional: TfrmRelFatProfissional;

implementation

uses untFuncoes, untfuncoesSimples, untModulo, untModuloSPR, DB, untPai,
   untQckFatProfissional, untModuloCadDiv;

{$R *.dfm}

procedure TfrmRelFatProfissional.FormCreate(Sender: TObject);
begin
  inherited;

  If intCaixa = 2 Then
  Begin

    If fMensagem('', 'Opção: ', ['Individual', 'Global']) = 1 Then
      intGlobal := 1
    Else
      intGlobal := 2;

  End;

  pAtualizaClaFis;

end;

procedure TfrmRelFatProfissional.FormShow(Sender: TObject);
begin
  inherited;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy', VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy', VS_Date);

end;

procedure TfrmRelFatProfissional.edtCodProfissionalExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodProfissional.Text) Then
    edtDesProfissional.Text := 'TODOS'
  Else
    edtDesProfissional.Text := fRetNomProfissional(edtCodProfissional.Text);

  If fEmptyStr(edtDesProfissional.Text) And (Not fEmptyStr(edtCodProfissional.Text)) Then
  Begin
    fMensagem('AVISO','Código do Profissional não encontrado',['&O K']);
    edtCodProfissional.Clear;
    edtCodProfissional.SetFocus;
  End;

end;

procedure TfrmRelFatProfissional.edtCodProfissionalKeyPress(
  Sender: TObject; var Key: Char);
  Var
    stlIndicePro, stlDesIndPro, stlCamposPro: TStringList;
    qryGenDiv: TUniQuery;

begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    stlIndicePro := TStringList.Create;
    stlDesIndPro := TStringList.Create;
    stlCamposPro := TStringList.Create;

    Key := #0;

    stlCamposPro.Add('DIV_CODDIV');
    stlCamposPro.Add('DIV_NOMDIV');
    stlCamposPro.Add('AUTOINCREM');

    stlIndicePro.Add('DIV_NOMDIV');
    stlIndicePro.Add('DIV_CODDIV');
    stlDesIndPro.Add('Nome');
    stlDesIndPro.Add('Código');

    qryGenDiv := frmModuloCadDiv.qryCadDiv;
    If pConsultaRapida(Self,qryGenDiv,'CADDIV',stlIndicePro,stlDesIndPro,stlCamposPro) Then
    Begin
      edtCodProfissional.Text := qryGenDiv.FieldByName('DIV_CODDIV').AsString;
      Self.SelectNext(ActiveControl,True,True);
    End;

    pCarregaProfissional(qryGenDiv);

    FreeAndNil(stlIndicePro);
    FreeAndNil(stlDesIndPro);
    FreeAndNil(stlCamposPro);

  End;

end;

procedure TfrmRelFatProfissional.pCarregaProfissional(Var qryCadDiv: TUniQuery);
begin

  If Not (fEmptyStr(edtCodProfissional.Text)) Then
    edtDesProfissional.Text := qryCadDiv.FieldByName('DIV_NOMDIV').AsString
  Else
    edtDesProfissional.Text := '';

end;

procedure TfrmRelFatProfissional.pAtualizaClaFis;
  Var
    strClaFis: String;
Begin
  //'5102_5403_5405_5655_5656_6102_6108_6404_6405_6655_6656_'

  strClaFis := VS_strClaVen;

  While Not fEmptyStr(strClaFis) Do
  Begin
    Application.ProcessMessages;

    lstClaFis.Lines.Add(LeftStr(strClaFis,4));

    strClaFis := RightStr(strClaFis, Length(strClaFis)-5 );
  End;

end;

function TfrmRelFatProfissional.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {*********************}
    {* VALIDA DATAS      *}
    {******************LU*}
    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
        If (Sender = mskDtaFin) Then
          Sender := mskDtaIni;
      End
      Else
      Begin
        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
              Result := False;
            End;
          End;
        End
      End;

    End

    Else
    If (Sender = edtTipo) Then
    Begin

      If fEmptyStr(edtTipo.Text) Then
      Begin
        fMensagem('AVISO','O campo Tipo deve ser A ou S!',['&O K']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    Sender.SetFocus;

end;

procedure TfrmRelFatProfissional.btnImprimirClick(Sender: TObject);
  Var
    strSQL   : String;
    strCreate: String;
    qryGenFis: TUniQuery;
    strUnion : String;
begin

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  qryGenFis := fCriaQuery(Self);

  inherited;

  If blnImprime Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CONCAT(DET_CODDIV,"-",DIV_NOMDIV) AS CODDIV, ';
    strSQL := strSQL + '  CONCAT(DET_NUMDOC,"-",DET_ESPDOC) AS NUMDOC, ';
    strSQL := strSQL + '  DET_DTAENT AS DTAENT, ';
    strSQL := strSQL + '  CONCAT(DET_CODVEN,"-",OPE_NOMOPE) AS CODVEN, ';
    strSQL := strSQL + '  CONCAT(DET_CODCLI,"-",CLI_NOMCLI) AS CODCLI, ';
    strSQL := strSQL + '  DET_CODEMP AS CODEMP, ';

    strSQL := strSQL + '  (IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF ), DET_TOTITE - DET_DESESP - DET_DESCFF))  AS  TOTITE  ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVDET, ';
    strSQL := strSQL + '  CADOPE, ';
    strSQL := strSQL + '  CADDIV, ';
    strSQL := strSQL + '  CADCLI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  DET_CODCLI NOT IN (' + VS_strCliFil + ') AND '; {EDUARDO}    
    strSQL := strSQL + '  DET_CODCLI = CLI_CODCLI AND ';
    strSQL := strSQL + '  DET_CODVEN = OPE_CODOPE AND ';
    strSQL := strSQL + '  DET_CODDIV = DIV_CODDIV AND ';

    strSQL := strSQL + '  DET_PROEMB <> "S"                       AND ';
    strSQL := strSQL + '  DET_TIP_FC = "C"                        AND ';
    strSQL := strSQL + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN  AND ';
    strSQL := strSQL + '  ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0))  ';

    If Not fEmptyStr(edtCodProfissional.Text) Then
      strSQL := strSQL + '  AND DET_CODDIV = :CODDIV ';

    {******************************}
    {* VERIFICAÇÃO DE CAIXA 1 E 2 *}
    {***************************LB*}
    If intGlobal = 1 Then
    Begin
      strSQL := AnsiReplaceStr(strSQL,'MOVDET','MOVDETX');
    End
    Else If intGlobal = 2 Then
    Begin
      strSQL  := strSQL + ' UNION ALL ' + AnsiReplaceStr(strSQL, 'MOVDET','MOVDETX');
    End;

    strUnion := strSQL;

    With frmModuloSPR.qryRelatorio Do
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  CODDIV, ';
      strSQL := strSQL + '  NUMDOC, ';
      strSQL := strSQL + '  CODVEN, ';
      strSQL := strSQL + '  DTAENT, ';
      strSQL := strSQL + '  CODCLI, ';
      strSQL := strSQL + '  CODEMP, ';

      strSQL := strSQL + '  SUM(TOTITE) AS TOTITE ';

      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  ( ' + strUnion + ') AS TAB ';

      If edtTipo.Text = 'A' Then
      Begin
        strSQL := strSQL + 'GROUP BY ';
        strSQL := strSQL + '  NUMDOC, CODEMP ';
      End
      Else
      Begin
        strSQL := strSQL + 'GROUP BY ';
        strSQL := strSQL + '  CODDIV ';
      End;

      strSQL := strSQL + 'ORDER BY ';
      strSQL := strSQL + '  CODDIV ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
      ParamByName('CLAFIS').AsString :=  VS_strClaVen;
      ParamByName('CLADEV').AsString := VS_strClaDev;

      If Not fEmptyStr(edtCodProfissional.Text) Then
        ParamByName('CODDIV').AsString := edtCodProfissional.Text;

      Open;
    End;

    If Not frmModuloSPR.qryRelatorio.IsEmpty Then
    Begin
      Try
        pCriarFormularios(TfrmQckFatProfissional,frmQckFatProfissional);

        If strTipImp = 'M' Then
          frmQckFatProfissional.qckPagina.DefaultFilter := rldFiltro
        Else
          frmQckFatProfissional.qckPagina.DefaultFilter := Nil;


        {********************}
        {* CABEÇALHO DO QCK *}
        {*****************LB*}

        frmQckFatProfissional.strOrdem := 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

        If Not fEmptyStr(edtCodProfissional.Text) Then
          frmQckFatProfissional.rllPintor.Caption :=  fCfgSis('PROFIS') + ': ' +  edtCodProfissional.Text + '-' + edtDesProfissional.Text
        Else
          frmQckFatProfissional.rllPintor.Caption := fCfgSis('PROFIS') + ': ' + ' TODOS ';


        If edtTipo.Text = 'A' Then
        Begin
          frmQckFatProfissional.rllNomeRelatorio.Caption := 'RELATORIO DE VENDAS POR ' + fCfgSis('PROFIS') + ' - ANALITICO ';
          frmQckFatProfissional.rlbTitulo.Visible := True;
          frmQckFatProfissional.rlbGrupo.Visible  :=True;
        End
        Else
        Begin
          frmQckFatProfissional.rllNomeRelatorio.Caption := 'RELATORIO DE VENDAS POR ' + fCfgSis('PROFIS') + ' - SINTETICO ';
          frmQckFatProfissional.rlbTituloSint.Visible := True;
          frmQckFatProfissional.rlbDetalhe.Visible    := True;
          frmQckFatProfissional.rlbTotGeral.Borders.DrawTop := True;
        End;

        {************************}
        {* VERIFICA CAIXA 1 E 2 *}
        {*********************LB*}
        If intGlobal = 0 Then
          frmQckFatProfissional.rllNomeRelatorio.Caption := frmQckFatProfissional.rllNomeRelatorio.Caption + ' [*]'
        Else If intGlobal = 1 Then
          frmQckFatProfissional.rllNomeRelatorio.Caption := frmQckFatProfissional.rllNomeRelatorio.Caption + ' [**]'
        Else
          frmQckFatProfissional.rllNomeRelatorio.Caption := frmQckFatProfissional.rllNomeRelatorio.Caption + ' [*/**]';

        If edtDestino.Text = 'V' Then
          frmQckFatProfissional.qckPagina.PreviewModal
        Else
          frmQckFatProfissional.qckPagina.Print;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[frmRelFatProfissional.btnImprimirClick]');
        End;
      End;

      pFreeAndNil(frmQckFatProfissional);

    End
    Else
    Begin
      pTabelaVazia;
    End;
  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';

  FreeAndNil(qryGenFis);

end;

end.

