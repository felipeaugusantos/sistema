unit untImportCotacaoItens;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, strUtils, ComObj, untFatorPreco, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, untPai, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Mask, FilenameEditFocus, untZClient, untFuncoesSimples, Uni, Data.DB,
  UniClientDataSet, cxGraphics, cxControls, cxLookAndFeels, Math,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, cxButtons,
  untParCalculaPrecoCusto, untTValidaExcel, cxProgressBar, Datasnap.DBClient, untTypesSistema,
  untGravando;

type

  TfrmImportCotacaoItens = class(TfrmPai)
    pnlfundo: TPanel;
    Label1: TLabel;
    btnGravar: TBitBtnLocked;
    edtPath: TFilenameEditFocus;
    btnHlpImp: TBitBtnLocked;
    frxHelp: TfrxReport;
    pgbGeral: TcxProgressBar;
    btnCancelaValidacao: TBitBtnLocked;
    procedure pLimparCDS;
    procedure btnGravarClick(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function  fTemTitulo: boolean;
    procedure btnCancelaValidacaoClick(Sender: TObject);

  protected
    function fCodIteExiste(AStrCodIte: String):Boolean;

  private
    blnArqCsv,
    FBlnProsseguirComArquivoInvalido: Boolean;
    objValidaExcel: TValidadorExcel;

    strDesValFre: String;

    intSequencial: Integer;
    procedure pProcessarArquivo;
    function fProcessaArquivoPrg(pgbProgress: TCxProgressBar): Boolean;
    function fConvertVazioToNull(texto: string): Variant;
    procedure pConfirma;
    function fValidaCodIte(strColuna, strTabela, strCampo, strValor: string;
      var strMensagem: String): boolean;

    const cQtdColunas = 2;
    const cCODITE = 'A';  // COD.CITEL
          cQTDITE = 'B';  // QTDITE

    const cDesCODITE = 'Cód. Produto';
          cDesQTDITE = 'Quantidade';

     Procedure pPreparaValidador;
     procedure pAtualizaInfoValidador;

     procedure pCriarDataSet;

    { Private declarations }
  public
    cdsItens : TUniClientDataSet;
    FBlnProcessarItens: Boolean;
  end;

  var
  frmImportCotacaoItens: TfrmImportCotacaoItens;

implementation

{$R *.dfm}

uses untTConfiguracao, untConstantes;

{ TfrmImportCotacaoItens }

function TfrmImportCotacaoItens.fValidaCodIte(strColuna, strTabela, strCampo, strValor: string; var strMensagem: String): boolean;
begin
  Result := True;
  If Not fCodIteExiste(strValor) Then
  Begin
    strMensagem := 'O item ' + strValor + ' não está cadastrado no sistema!';
    Result := False;
  End;

  If fCampoTabela('ITE_ATICOM', 'CADITE', ['ITE_CODITE'], [strValor]) = 'N' Then
  Begin
    strMensagem := 'O item ' + strValor + ' não está ativo para compras!';
    Result := False;
  End;
end;

procedure TfrmImportCotacaoItens.pPreparaValidador;
Begin
  If Not Assigned(objValidaExcel) Then
    Exit;
  objValidaExcel.FAtualizaStatus := pAtualizaInfoValidador;
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesCODITE, cCODITE, fTamCodIte, True, False, fValidaCodIte));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesQTDITE, cQTDITE));
End;

procedure TfrmImportCotacaoItens.btnCancelaValidacaoClick(Sender: TObject);
begin
  inherited;
  objValidaExcel.blnCancela := True;
end;

procedure TfrmImportCotacaoItens.pProcessarArquivo;
begin
  TfrmGravando.fExecuta(fProcessaArquivoPrg, frmGravando, 'Importando produtos, aguarde...');
end;

function TfrmImportCotacaoItens.fCodIteExiste(AStrCodIte: String): Boolean;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriarQuery('SELECT ITE_CODITE FROM CADITE WHERE ITE_CODITE = ' + QuotedStr(AStrCodIte));
  Try
    qryAux.Open;
    Result := Not qryAux.IsEmpty;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmImportCotacaoItens.fConvertVazioToNull(texto: string): Variant;
begin
  If Texto = '' Then
    Result := null
  Else
    Result := texto;
end;

procedure TfrmImportCotacaoItens.btnGravarClick(Sender: TObject);
begin
  pConfirma;
end;

procedure TfrmImportCotacaoItens.pConfirma;
 Var
   ArrCamposReplaceCharEspecial : TArrCamposReplaceCharEspecial;
begin
  inherited;

  FBlnProcessarItens := False;
  FBlnProsseguirComArquivoInvalido := True;

  {*******************************}
  { VERIRICA SE O ARQUIVO EXISTE  }
  {****************************LU*}
  If Not (FileExists(edtPath.Text)) Then
  Begin
    fMensagem('AVISO','Arquivo não encontrado : ' + edtPath.Text + ' !', ['&O K']);
    Exit;
  End;

  try
    objValidaExcel := TValidadorExcel.Create(edtPath.text, cQtdColunas, cCODITE, '', 0, ArrCamposReplaceCharEspecial);

    Try
      pPreparaValidador;
      pgbGeral.Visible := True;
      btnGravar.Enabled := True;
      btnCancelaValidacao.Visible := True;
      If Not objValidaExcel.fValidaCampos(True, pgbGeral) Then
      Begin
          FBlnProsseguirComArquivoInvalido :=
              fMensagem('Atenção', 'Foram encontradas inconsistências no seu arquivo, deseja prosseguir mesmo assim?'+#13+
              'Os itens não ativos para compras e os não localizados no sistema não serão importados!', ['&Sim', '&Não']) = 1 ;
      End;
    Finally
        btnGravar.Enabled := False;
        btnCancelaValidacao.Visible := False;
    End;

    If FBlnProsseguirComArquivoInvalido Then
      pProcessarArquivo;

  Finally
    btnSair.Enabled       := True;
    edtPath.Enabled       := True;

    btnHlpImp.Enabled := True;
    btnGravar.Enabled := True;
    pnlInfo.Caption := '';
    FreeAndNil(objValidaExcel);
    pgbGeral.Visible := False;
  End;
End;

function TfrmImportCotacaoItens.fProcessaArquivoPrg(pgbProgress: TCxProgressBar): Boolean;
var
   intValIni,
   intContador : Integer;
   strCodIte,
   strAtiCom: String;
   fltQtdIte: Double;
   blnProdExiste,
   blnPodeInserir: Boolean;
begin
  Result := False;

  If fVerificaCampos Then
  Begin
    btnHlpImp.Enabled     := False;
    btnGravar.Enabled     := False;
    btnSair.Enabled       := False;
    edtPath.Enabled       := False;

    pnlInfo.Caption       := 'Aguarde... Importando itens...';

    Try
      pgbGeral.Properties.Max := objValidaExcel.ArquivoCSV.Count;

      pgbGeral.Position := 0;

      pLimparCDS;
      intValIni := IIf(fTemTitulo, 1 , 0);
      intSequencial := 1;
      For intContador := intValIni To (objValidaExcel.ArquivoCSV.Count -1) Do
      Begin
        If blnArqCsv Then
          If intContador > objValidaExcel.ArquivoCSV.Count Then
            Continue;

        Try
          strCodIte := fConvertVazioToNull(objValidaExcel.fGetValueCSV(intContador, cCODITE));
        Except
          strCodIte := '';
        End;

        strAtiCom := fCampoTabela('ITE_ATICOM', 'CADITE', ['ITE_CODITE'], [(strCodIte)]);
        blnProdExiste := fCodIteExiste(strCodIte);

        Try
          fltQtdIte := fConvertVazioToNull(objValidaExcel.fGetValueCSV(intContador, cQTDITE));
        Except
          fltQtdIte := 0;
        End;

        blnPodeInserir := (fltQtdIte > 0) And (strAtiCom = 'S') And (blnProdExiste);

        If blnPodeInserir Then
        Begin
          cdsItens.Insert;
          cdsItens.FieldByName('CODITE').AsString := strCodIte;
          cdsItens.FieldByName('QTDITE').AsFloat := fltQtdIte;
          cdsItens.Post;

          pgbGeral.Position := pgbGeral.Position + 1;
          Application.ProcessMessages;
          inc(intSequencial);
        End;
      End;

      SetForegroundWindow(Handle);

      edtPath.Clear;
      btnHlpImp.Enabled     := True;
      btnGravar.Enabled     := True;
      btnSair.Enabled       := True;
      edtPath.Enabled       := True;
      pnlInfo.Caption       := '';
      pgbGeral.Position     := 0;
      pSetFocus(btnSair);
      FBlnProcessarItens    := True;

      Result := True;
      Close;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmImportCadProduto.btnGravarClick]');
        btnHlpImp.Enabled     := True;
        btnGravar.Enabled     := True;
        btnSair.Enabled       := True;
        edtPath.Enabled       := True;
        pnlInfo.Caption       := '';
        pgbGeral.Position     := 0;
        pSetFocus(btnSair);
      End;
    End;

  End;
end;

procedure TfrmImportCotacaoItens.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
end;

procedure TfrmImportCotacaoItens.pAtualizaInfoValidador;
begin
  PnlInfo.Caption := objValidaExcel.TempoExtimado;
end;

procedure TfrmImportCotacaoItens.FormCreate(Sender: TObject);
begin
  inherited;
  edtPath.Dialog.Dialog.Filter := 'Arquivos Suportados|*.xls;*.xlsx;*.csv';

  strDesValFre := fCfgSis('DESVFR');
  pCriarDataSet;
end;

procedure TfrmImportCotacaoItens.pCriarDataSet;
begin
  cdsItens := TUniClientDataSet.Create(Nil);
  cdsItens.FieldDefs.Add('CODITE', ftString, fTamCodIte);
  cdsItens.FieldDefs.Add('QTDITE', ftFloat);

  cdsItens.CreateDataSet;
end;

function TfrmImportCotacaoItens.fTemTitulo: boolean;
  var
    intValDef: Integer;
begin
  If objValidaExcel.fGetValueCSV(0, cCODITE) <> '' Then
    Result := not TryStrToInt(Trim(objValidaExcel.fGetValueCSV(0, cCODITE)), intValDef)
  Else
    Result := False;
end;

procedure TfrmImportCotacaoItens.pLimparCDS;
begin
  cdsItens.EmptyDataSet;
end;

end.








