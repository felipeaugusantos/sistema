
unit untImportProdutoVeiculo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, untZClient,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxButtonEdit, FilenameEditFocus, Vcl.ComCtrls, System.StrUtils, untTValidaExcel,
  cxProgressBar, untTCadProdutosVeiculoModelo, Uni;

type
  TfrmImportProdutoVeiculo = class(TfrmPai)
    btnHlpImp: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    pnlfundo: TPanel;
    Label1: TLabel;
    edtPath: TFilenameEditFocus;
    frxHelp: TfrxReport;
    pgbGeral: TcxProgressBar;
    procedure btnGravarClick(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    objCadProdutosVeiculoModelo : TCadProdutosVeiculoModelo;
    objValidaExcel: TValidadorExcel;
    cdsProVei : TZClient;
    procedure pCriarCds;
    procedure pAtualizaInfoValidador;
    procedure pPreparaValidador;
    procedure pProcessaItens;
    function fGetSqlCds: string;
    procedure pExibeTela;
    function fConvetVazioToNull(texto: string): Variant;
    procedure pLimparCDS;
    function fTemTitulo: boolean;
    function fValidaNumerico(strColuna, strTabela, strCampo, strValor: string;
      var strMensagem: String): boolean;
    function fValidaAno(strColuna, strTabela, strCampo, strValor: string;
      var strMensagem: String): boolean;
    procedure pInsereItensCDS(intLinha: integer);
    function fValidaListaCombustivel(strColuna, strTabela, strCampo,
      strValor: string; var strMensagem: String): boolean;
    function fExisteChaveUnica(intLinha: Integer): Boolean;
    function fConsultaChaveUnica(strCodIte, strCodMod, strCodMar,
      strAnoIni: String): Boolean;
    function fConsultaProduto(strCodIte: String): Boolean;
    function fExisteProduto(intLinha: Integer): Boolean;
    function fModeloVinculadoAMarca(intLinha: Integer): Boolean;
    function fRegistroJahInserido(intLinha: Integer): Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

    const cQtdColunas = 11;
    const cVEI_CODITE = 'A';
          cMOD_CODMAR = 'B';
          cMOD_CODMOD = 'C';
          cMOD_ANOINI = 'D';
          cMOD_ANOFIN = 'E';
          cMOD_VALVUL = 'F';
          cMOD_CILIND = 'G';
          cMOD_POTENC = 'H';
          cMOD_COMBUS = 'I';
          cVEI_OBSERV = 'J';
          cMOD_OBSERV = 'K';


    const cDesVEI_CODITE = 'Código Item';
          cDesMOD_CODMOD = 'Modelo';
          cDesMOD_CODMAR = 'Marca';
          cDesMOD_ANOINI = 'Ano Inicial';
          cDesMOD_ANOFIN = 'Ano Final';
          cDesMOD_VALVUL = 'Válvula';
          cDesMOD_CILIND = 'Cilindrada';
          cDesMOD_POTENC = 'Potência';
          cDesMOD_COMBUS = 'Combustível';
          cDesVEI_OBSERV = 'Obs. do Produto';
          cDesMOD_OBSERV = 'Observações';

var
  frmImportProdutoVeiculo: TfrmImportProdutoVeiculo;

implementation

uses
  untFuncoesSimples, untImportProdutoVeiculoConfirma;

{$R *.dfm}

procedure TfrmImportProdutoVeiculo.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
end;

procedure TfrmImportProdutoVeiculo.pAtualizaInfoValidador;
begin
  PnlInfo.Caption := objValidaExcel.TempoExtimado;
end;

function TfrmImportProdutoVeiculo.fValidaNumerico(strColuna, strTabela, strCampo,
  strValor: string; var strMensagem: String): boolean;
begin
  Try
    StrToInt(strValor);
    Result := True;
  Except On
    E:Exception Do
    Begin
      strMensagem := 'O campo informado não é um valor em formato númerico válido';
      Result := False;
    End;
  End;
end;

function TfrmImportProdutoVeiculo.fValidaAno(strColuna, strTabela, strCampo,
  strValor: string; var strMensagem: String): boolean;
begin
  Result := True;
  if strValor.Trim.IsEmpty then
    Exit;

  Try
    StrToInt(strValor);
  Except On
    E:Exception Do
    Begin
      strMensagem := 'O campo informado não é um valor em formato de data válido';
      Result := False;
    End;
  End;
end;

procedure TfrmImportProdutoVeiculo.pPreparaValidador;
Begin
  If Not Assigned(objValidaExcel) Then
    Exit;
  objValidaExcel.FAtualizaStatus := pAtualizaInfoValidador;
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesVEI_CODITE, cVEI_CODITE, 5, False, True, fValidaNumerico));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesMOD_CODMOD, cMOD_CODMOD, 4, False, True, fValidaNumerico));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesMOD_CODMAR, cMOD_CODMAR, 4, False, True, fValidaNumerico));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesMOD_ANOINI, cMOD_ANOINI, 0, False, True, fValidaAno));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesMOD_ANOFIN, cMOD_ANOFIN, 0, False, False, fValidaAno));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoInt(cDesMOD_VALVUL, cMOD_VALVUL, False));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesMOD_CILIND, cMOD_CILIND, 0, False, False, ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoInt(cDesMOD_POTENC, cMOD_POTENC,  False));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesMOD_COMBUS, cMOD_COMBUS, 0, False, False, fValidaListaCombustivel));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesVEI_OBSERV, cVEI_OBSERV, 0, False, False, ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesMOD_OBSERV, cMOD_OBSERV, 0, False, False, ''));
End;

function TfrmImportProdutoVeiculo.fValidaListaCombustivel(strColuna, strTabela, strCampo,
  strValor: string; var strMensagem: String): boolean;
var
  i: integer;
  strValorLista: String;
  lst: TStringList;

begin
  Result := True;

  if strValor.Trim.IsEmpty then
    Exit;

  lst := TStringList.Create;
  try
    lst.Text := '';
    lst.StrictDelimiter := True;
    lst.Delimiter := ',';
    lst.DelimitedText := strValor;

    For i := 0 To Pred(lst.Count) do
    Begin
      strValorLista := Trim(lst[i]);

      If not objCadProdutosVeiculoModelo.fCombustivelExiste(strValorLista) Then
      Begin
        Result := False;
        strMensagem := 'Não foi encontrada nenhum tipo de combustível ' + strValorLista + ' na lista';
        Break;
      End;
    End;
  finally
    lst.DisposeOf;
  end;
end;

procedure TfrmImportProdutoVeiculo.pProcessaItens;
var intValIni,
    intContador: Integer;
begin
  pgbGeral.Properties.Max := objValidaExcel.ArquivoCSV.Count -1;

  pgbGeral.Position := 0;
    pLimparCDS;
  try
    intValIni := IIf(fTemTitulo, 1 , 0);
    pgbGeral.Position := 0;
    For intContador := intValIni To (objValidaExcel.ArquivoCSV.Count -1) Do
    Begin
      pnlInfo.Caption := 'Importando os veículos...'+ IntToStr(intContador) +'/' +IntToStr(objValidaExcel.ArquivoCSV.Count);
      If intContador > objValidaExcel.ArquivoCSV.Count Then
        Continue;
      pInsereItensCDS(intContador);
      pgbGeral.Position := pgbGeral.Position + 1;
      Application.ProcessMessages;
    End;

    If Not cdsProVei.isEmpty Then
      pExibeTela;
  except
    on e: Exception do
      fMensagem('AVISO',e.message, ['&O K']);
  end;
end;

function TfrmImportProdutoVeiculo.fGetSqlCds: string;
var
  strSql: string;
begin
  strSql := '';
  strSql := strSql + 'SELECT ';
  strSql := strSql + '  VEIPRO.VEI_CODITE, ';
  strSql := strSql + '  DETMOD.MOD_CODMOD, ';
  strSql := strSql + '  MODVEI.MOD_CODMAR, ';
  strSql := strSql + '  DETMOD.MOD_ANOINI, ';
  strSql := strSql + '  DETMOD.MOD_ANOFIN, ';
  strSql := strSql + '  DETMOD.MOD_VALVUL, ';
  strSql := strSql + '  DETMOD.MOD_CILIND, ';
  strSql := strSql + '  DETMOD.MOD_POTENC, ';
  strSql := strSql + '  DETMOD.MOD_COMBUS, ';
  strSql := strSql + '  VEIPRO.VEI_OBSERV, ';
  strSql := strSql + '  DETMOD.MOD_OBSERV  ';
  strSql := strSql + 'FROM ';
  strSql := strSql + '  DETMOD ';
  strSql := strSql + '  INNER JOIN MODVEI ';
  strSql := strSql + '    ON MODVEI.MOD_CODMOD = DETMOD.MOD_CODMOD ';
  strSql := strSql + '  INNER JOIN VEIPRO ';
  strSql := strSql + '    ON VEIPRO.VEI_CODMOD = DETMOD.AUTOINCREM ';
  strSql := strSql + '  JOIN CADITE ';
  strSql := strSql + '    ON CADITE.ITE_CODITE = VEIPRO.VEI_CODITE ';
  strSql := strSql + '  INNER JOIN MARVEI ';
  strSql := strSql + '    ON MAR_CODMAR = MOD_CODMAR ';
  strSql := strSql + 'WHERE FALSE ';

  Result := strSql;
end;

procedure TfrmImportProdutoVeiculo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (Assigned(objCadProdutosVeiculoModelo)) Then
    FreeAndNil(objCadProdutosVeiculoModelo);
end;

procedure TfrmImportProdutoVeiculo.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsProVei);
end;

procedure TfrmImportProdutoVeiculo.FormShow(Sender: TObject);
begin
  inherited;
  objCadProdutosVeiculoModelo := TCadProdutosVeiculoModelo.Create;
end;

procedure TfrmImportProdutoVeiculo.pCriarCds;
begin
  cdsProVei := TZClient.Create(Self, fGetSqlCds);
  cdsProVei.fAbreClient(True, '[TfrmImportProdutoVeiculo.pCriarCds]');
  cdsProVei.LogChanges := False;
end;

procedure TfrmImportProdutoVeiculo.pExibeTela;
begin
  If not cdsProVei.IsEmpty Then
  Begin
   pCriarFormularios(TfrmImportProdutoVeiculoConfirma, frmImportProdutoVeiculoConfirma);
    Try
      frmImportProdutoVeiculoConfirma.cdsProVei := cdsProVei;
      frmImportProdutoVeiculoConfirma.ShowModal;
    Finally
      pFreeAndNil(frmImportProdutoVeiculoConfirma);
    End;
  End;
end;

procedure TfrmImportProdutoVeiculo.btnGravarClick(Sender: TObject);
begin
  If Not (FileExists(edtPath.Text)) Then
  Begin
    fMensagem('AVISO','Arquivo não encontrado : ' + edtPath.Text + ' !', ['&O K']);
    Exit;
  End;

  try
    objValidaExcel := TValidadorExcel.Create(edtPath.text, cQtdColunas, cVEI_CODITE, '', 0);

    Try
      pPreparaValidador;
      pgbGeral.Visible := True;
      btnGravar.Enabled := True;
      If Not objValidaExcel.fValidaCampos(True, pgbGeral) Then
        Exit;
    Finally
      btnGravar.Enabled := False;
    End;

    btnHlpImp.Enabled     := False;
    btnGravar.Enabled     := False;
    btnSair.Enabled       := False;
    edtPath.Enabled       := False;

    Mouse.SettingChanged(10);
    pgbGeral.Visible := True;
    Application.ProcessMessages;
    edtPath.Text := AnsiReplaceStr(edtPath.Text,'"','');
    pCriarCds;
    Try
      pProcessaItens;

      SetForegroundWindow(Handle);

      edtPath.Clear;
      btnHlpImp.Enabled     := True;
      btnGravar.Enabled     := True;
      btnSair.Enabled       := True;
      edtPath.Enabled       := True;
      pnlInfo.Caption       := '';
      pgbGeral.Position     := 0;
      pSetFocus(btnSair);
      cdsProVei.Close;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmImportProdutoVeiculo.btnGravarClick]');
        btnHlpImp.Enabled     := True;
        btnGravar.Enabled     := True;
        btnSair.Enabled       := True;
        edtPath.Enabled       := True;
        pnlInfo.Caption       := '';
        pgbGeral.Position     := 0;
        pSetFocus(btnSair);
      End;
    End;
  Finally
    btnSair.Enabled       := True;
    edtPath.Enabled       := True;

    btnHlpImp.Enabled := True;
    btnGravar.Enabled := True;
    pnlInfo.Caption := '';
    FreeAndNil(objValidaExcel);
    pgbGeral.Visible := False;

  End
end;

function TfrmImportProdutoVeiculo.fConvetVazioToNull(texto: string): Variant;
begin
  If Texto = '' Then
    Result := null
  Else
    Result := texto;
end;

procedure TfrmImportProdutoVeiculo.pLimparCDS;
begin
  cdsProVei.EmptyDataSet;
end;

function TfrmImportProdutoVeiculo.fTemTitulo: boolean;
  var
    intValDef: Integer;
begin
  If objValidaExcel.fGetValueCSV(0, cVEI_CODITE) <> '' Then
    Result := not TryStrToInt(Trim(objValidaExcel.fGetValueCSV(0, cVEI_CODITE)), intValDef)
  Else
    Result := False;
end;

procedure TfrmImportProdutoVeiculo.pInsereItensCDS(intLinha: integer);
begin
  if not fExisteProduto(intLinha) then
    raise Exception.Create('Linha: ' + IntToStr(intLinha + 1) + SLineBreak + 'Não apresenta código de produto válido para importação.');

  if not fModeloVinculadoAMarca(intLinha) then
    raise Exception.Create('Linha: ' + IntToStr(intLinha + 1) + SLineBreak + 'Modelo não vinculado a marca.');

  if not fExisteChaveUnica(intLinha) then
    raise Exception.Create('Linha: ' + IntToStr(intLinha + 1) + SLineBreak + Format('Cód. Item %s, já vinculado com este Veículo %s - %s - %s.',
                                                                                   [objValidaExcel.fGetValueCSV(intLinha, cVEI_CODITE),
                                                                                    objValidaExcel.fGetValueCSV(intLinha, cMOD_CODMAR),
                                                                                    objValidaExcel.fGetValueCSV(intLinha, cMOD_CODMOD),
                                                                                    objValidaExcel.fGetValueCSV(intLinha, cMOD_ANOINI)]));

  if fRegistroJahInserido(intLinha) then
    raise Exception.Create('Linha: ' + IntToStr(intLinha + 1) + SLineBreak + Format('As informações Cód. Item: %s Marca: %s Modelo: %s Ano Inicial: %s estão duplicadas no arquivo.',
                                                                                   [objValidaExcel.fGetValueCSV(intLinha, cVEI_CODITE),
                                                                                    objValidaExcel.fGetValueCSV(intLinha, cMOD_CODMAR),
                                                                                    objValidaExcel.fGetValueCSV(intLinha, cMOD_CODMOD),
                                                                                    objValidaExcel.fGetValueCSV(intLinha, cMOD_ANOINI)]));

  cdsProVei.Insert;
  cdsProVei.FieldByName('VEI_CODITE').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cVEI_CODITE));
  cdsProVei.FieldByName('MOD_CODMAR').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMOD_CODMAR));
  cdsProVei.FieldByName('MOD_CODMOD').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMOD_CODMOD));
  cdsProVei.FieldByName('MOD_ANOINI').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMOD_ANOINI));
  cdsProVei.FieldByName('MOD_ANOFIN').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMOD_ANOFIN));
  cdsProVei.FieldByName('MOD_VALVUL').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMOD_VALVUL));
  cdsProVei.FieldByName('MOD_CILIND').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMOD_CILIND));
  cdsProVei.FieldByName('MOD_POTENC').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMOD_POTENC));
  cdsProVei.FieldByName('MOD_COMBUS').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMOD_COMBUS));
  cdsProVei.FieldByName('VEI_OBSERV').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cVEI_OBSERV));
  cdsProVei.FieldByName('MOD_OBSERV').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMOD_OBSERV));
  cdsProVei.Post;
end;

function TfrmImportProdutoVeiculo.fRegistroJahInserido(intLinha: Integer): Boolean;
var
  strCodIte,
  strCodMod,
  strCodMar,
  strAnoIni: String;
begin
  strCodIte := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cVEI_CODITE));
  strCodMod := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMOD_CODMOD));
  strCodMar := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMOD_CODMAR));
  strAnoIni := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMOD_ANOINI));
  Result := cdsProVei.Locate('VEI_CODITE;MOD_CODMOD;MOD_CODMAR;MOD_ANOINI', VarArrayOf([strCodIte, strCodMod, strCodMar, strAnoIni]), []);
end;

function TfrmImportProdutoVeiculo.fModeloVinculadoAMarca(intLinha: Integer): Boolean;
var
  strCodMod,
  strCodMar: String;
begin
  strCodMod := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMOD_CODMOD));
  strCodMar := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMOD_CODMAR));
  Result := objCadProdutosVeiculoModelo.fModeloPertenceAMarca(strCodMod, strCodMar);
end;

function TfrmImportProdutoVeiculo.fExisteProduto(intLinha: Integer): Boolean;
var
  strCodIte: String;
begin
  strCodIte := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cVEI_CODITE));
  Result := fConsultaProduto(strCodIte);
end;

function TfrmImportProdutoVeiculo.fConsultaProduto(strCodIte: String): Boolean;
var
  qryTemp: TUniQuery;
begin
  Try
    qryTemp := fCriaQuery;
    qryTemp.SQL.Add(' SELECT ITE_CODITE ');
    qryTemp.SQL.Add(' FROM CADITE ');
    qryTemp.SQL.Add(' WHERE ITE_CODITE = :CODITE ');
    qryTemp.ParamByName('CODITE').AsString := strCodIte;
    qryTemp.Open;

    Result := Not qryTemp.IsEmpty;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

function TfrmImportProdutoVeiculo.fExisteChaveUnica(intLinha: Integer): Boolean;
var
  strCodIte,
  strCodMod,
  strCodMar,
  strAnoIni: String;
begin
  strCodIte := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cVEI_CODITE));
  strCodMod := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMOD_CODMOD));
  strCodMar := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMOD_CODMAR));
  strAnoIni := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cMOD_ANOINI));
  Result := not fConsultaChaveUnica(strCodIte, strCodMod, strCodMar, strAnoIni);
end;

function TfrmImportProdutoVeiculo.fConsultaChaveUnica(strCodIte, strCodMod, strCodMar, strAnoIni: String): Boolean;
var
  qryTemp: TUniQuery;
begin
  Try
    qryTemp := fCriaQuery;
    qryTemp.SQL.Add(' SELECT VEIPRO.VEI_CODITE, MODVEI.MOD_CODMOD ');
    qryTemp.SQL.Add(' FROM VEIPRO ');
    qryTemp.SQL.Add(' INNER JOIN DETMOD ON DETMOD.AUTOINCREM = VEIPRO.VEI_CODMOD ');
    qryTemp.SQL.Add(' INNER JOIN MODVEI ON DETMOD.MOD_CODMOD = MODVEI.MOD_CODMOD ');
    qryTemp.SQL.Add(' WHERE MODVEI.MOD_CODMOD = :CODMOD AND VEIPRO.VEI_CODITE = :CODITE ');
    qryTemp.SQL.Add(' AND MODVEI.MOD_CODMAR = :CODMAR AND DETMOD.MOD_ANOINI = :ANOINI ');
    qryTemp.ParamByName('CODMOD').AsString := strCodMod;
    qryTemp.ParamByName('CODITE').AsString := strCodIte;
    qryTemp.ParamByName('CODMAR').AsString := strCodMar;
    qryTemp.ParamByName('ANOINI').AsString := strAnoIni;
    qryTemp.Open;

    Result := Not qryTemp.IsEmpty;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

end.
