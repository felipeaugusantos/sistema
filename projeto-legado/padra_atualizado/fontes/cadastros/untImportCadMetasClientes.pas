unit untImportCadMetasClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxProgressBar, cxTextEdit,
  cxMaskEdit, cxButtonEdit, FilenameEditFocus, untImportCadMetasClientesConfirma,
  untTValidaExcel, System.Win.ComObj, untFuncoesSimples, Uni, Data.DB, System.StrUtils;

type
  TfrmImportCadMetasClientes = class(TfrmPai)
    pnlfundo: TPanel;
    Label1: TLabel;
    edtPath: TFilenameEditFocus;
    pgbGeral: TcxProgressBar;
    btnGravar: TBitBtnLocked;
    btnCancelaValidacao: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaValidacaoClick(Sender: TObject);
  private
    { Private declarations }
    procedure pCriarDataSet(FImportMetasClientes: TfrmImportCadMetasClientesConfirma);
    procedure pFormataCampos(FImportMetasClientes: TfrmImportCadMetasClientesConfirma);
    procedure pInsereItensCDS(intLinha: integer; FImportMetasClientes: TfrmImportCadMetasClientesConfirma);
    procedure pAtualizaInfoValidador;
    procedure pPreparaValidador;
    procedure pValidaCampoVazio(strInfo: Variant);
    procedure pValidaCampoPreenchido(strInfo: Variant);
    procedure pVerificaDataPreenchida(strDataIni, strDataFim: String);
    procedure pValidaTrueFalse(blnCampoEmBranco: Boolean);

    function AbreExcel(FImportMetasClientes: TfrmImportCadMetasClientesConfirma): Boolean;
    function fTemTitulo: boolean;
    function fConvetVazioToNull(texto: string): Variant;
    function fMetaEncontradaNoBanco(strCodCli, strTipMet, strDataIni, strDataFim: String): Boolean;
    function fValidaTipoMet(strValor: Variant; inLinhaAtual: Integer; var strMensagem: String): Boolean;
  public
    { Public declarations }
  end;

var
  frmImportCadMetasClientes: TfrmImportCadMetasClientes;
  Excel         : Variant;
  intSequencial : Integer;
  blnArqCsv     : Boolean;
  objValidaExcel: TValidadorExcel;
  FCodCli,
  FcodVen,
  FDatIni,
  FDatFim,
  FCodMar,
  FCodLin,
  FCodFor,
  FCodDep,
  FTipMet: String;
  FValMet,
  FPerDes: Double;



const
  cQtdColunas = 11;

  cCodCli = 'A';  // Código do cliente
  cCodVen = 'B';  // Código do vendedor
  cDatIni = 'C';  // Data Inicial do Período
  cDatFim = 'D';  // Data Final do Período
  cCodMar = 'E';  // Código da Marca
  cCodLin = 'F';  // Código da Linha/Grupo
  cCodFor = 'G';  // Código do Fornecedor
  cCodDep = 'H';  // Código do Departamento
  cTipMet = 'I';  // Tipo de Meta (V)alor (L)itros/Kilos
  cValMet = 'J';  // Valor da Meta
  cPerDes = 'K';  // % de Desconto

  cDesCodCli = 'Cod. Cliente';  // Código do cliente
  cDesCodVen = 'Cod. Vendedor';  // Código do vendedor
  cDesDatIni = 'Data do Período Inicial';  // Data Inicial do Período
  cDesDatFim = 'Data do Período Final';  // Data Final do Período
  cDesCodMar = 'Cod. Marca';  // Código da Marca
  cDesCodLin = 'Cod. Linha/Grupo';  // Código da Linha/Grupo
  cDesCodFor = 'Cod. Fornecedor';  // Código do Fornecedor
  cDesCodDep = 'Cod. Departamento';  // Código do Departamento
  cDesTipMet = 'Tipo Meta';  // Tipo de Meta (V)alor (L)itros/Kilos
  cDesValMet = 'Valor da Meta';  // Valor da Meta
  cDesPerDes = 'Percentual de Desconto';  // % de Desconto


implementation

{$R *.dfm}

function TfrmImportCadMetasClientes.AbreExcel(FImportMetasClientes: TfrmImportCadMetasClientesConfirma): Boolean;
Var
  intValIni, intContador : Integer;
begin
  Result:= True;
  pgbGeral.Position := 0;
  pnlInfo.Caption       := 'Aguarde... Carregando Arquivo Excel...';

  objValidaExcel := TValidadorExcel.Create(edtPath.text, cQtdColunas, cCodCli, '');

  If fMensagem('Atenção', 'Deseja validar os dados contidos no arquivo informado?', ['&Sim', '&Não']) = 1 Then
  Begin
    Try
      pPreparaValidador;
      pgbGeral.Visible := True;
      btnGravar.Enabled := True;
      btnCancelaValidacao.Visible := True;
      If Not objValidaExcel.fValidaCampos(True, pgbGeral) Then
      Begin
        Result:= False;
        Exit;
      End;
    Finally
      btnGravar.Enabled := False;
      btnCancelaValidacao.Visible := False;
    End;
  End;


  blnArqCsv := UpperCase(ExtractFileExt(objValidaExcel.NomeArquivo)) = '.CSV';


  Try
    pValidaTrueFalse(blnArqCsv);
    Excel := CreateOleObject('Excel.Application');
    Excel.Visible       := False;
    Excel.DisplayAlerts := False;
    Excel.WorkBooks.Open(edtPath.Text);

    Excel.Selection.SpecialCells(11).Select;

    pgbGeral.Properties.Max := Excel.ActiveCell.Row -1;

  Except
    on E: Exception do
    Begin
      pgbGeral.Properties.Max := objValidaExcel.ArquivoCSV.Count;
    End;
  End;

  pgbGeral.Position := 0;
  pnlInfo.Caption       := 'Aguarde... Carregando Cadastro de Metas...';

  Mouse.SettingChanged(10);
  pgbGeral.Visible := True;
  Application.ProcessMessages;
  pnlInfo.Caption       := 'Aguarde... Importando Tabela Cadastro de Metas...';

  pCriarDataSet(FImportMetasClientes);
  pFormataCampos(FImportMetasClientes);

  intValIni := IIf(fTemTitulo, 1 , 0);
  intSequencial := 1;
  For intContador := intValIni To (objValidaExcel.ArquivoCSV.Count -1) Do
  Begin
    If blnArqCsv Then
      If intContador > objValidaExcel.ArquivoCSV.Count Then
        Continue;
    pInsereItensCDS(intContador, FImportMetasClientes);
    pgbGeral.Position := pgbGeral.Position + 1;
    Application.ProcessMessages;
    inc(intSequencial);
  End;

  pnlInfo.Caption       := 'Informações Carregadas...';
end;

procedure TfrmImportCadMetasClientes.btnCancelaValidacaoClick(Sender: TObject);
begin
  inherited;
  objValidaExcel.blnCancela := True;
end;

procedure TfrmImportCadMetasClientes.btnGravarClick(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtPath.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'Informe o caminho do arquivo para a importação!', ['&Ok']);
    Exit;
  End;

  If Not (FileExists(edtPath.Text)) Then
  Begin
    fMensagem('AVISO','Arquivo não encontrado : ' + edtPath.Text + ' !', ['&O K']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmImportCadMetasClientesConfirma, frmImportCadMetasClientesConfirma);
    If AbreExcel(frmImportCadMetasClientesConfirma) Then
      frmImportCadMetasClientesConfirma.ShowModal;
    If frmImportCadMetasClientesConfirma.ModalResult = mrOK Then
      fMensagem('AVISO','Importação realizada com sucesso!', ['&O K']);
  Finally
    pFreeAndNil(frmImportCadMetasClientesConfirma);
  End;

end;

function TfrmImportCadMetasClientes.fConvetVazioToNull(texto: string): Variant;
begin
  If Texto = '' Then
    Result := null
  Else
    Result := texto;
end;

function TfrmImportCadMetasClientes.fMetaEncontradaNoBanco(strCodCli,
  strTipMet, strDataIni, strDataFim: String): Boolean;
Var
  qryConsulta: TUniQuery;
  blnMetaEncontradaNoBanco: Boolean;
begin
  Result:= False;

  blnMetaEncontradaNoBanco:= True;

  Try
    pValidaTrueFalse(fEmptyStr(strCodCli));
    pValidaTrueFalse(fEmptyStr(strDataIni));
    pValidaTrueFalse(fEmptyStr(strDataFim));
  Except
    On E: Exception do
    Begin
      blnMetaEncontradaNoBanco:= False;
    End;

  End;

  qryConsulta:= fCriaQuery();
  Try
    If blnMetaEncontradaNoBanco Then
    Begin

      qryConsulta.Close;
      qryConsulta.SQL.Clear;
      qryConsulta.SQL.Add('SELECT C.CLI_CODVEN, M.* FROM METCLI M');
      qryConsulta.SQL.Add('INNER JOIN CADCLI C ON C.CLI_CODCLI =  M.MCL_CODCLI ');
      qryConsulta.SQL.Add('WHERE M.MCL_CODCLI  = :CODCLI ');
      qryConsulta.SQL.Add('  AND M.MCL_DTAINI >= :DTAINI ');
      qryConsulta.SQL.Add('  AND M.MCL_DTAFIN <= :DTAFIN ');
      qryConsulta.SQL.Add('  AND M.MCL_CODEMP <= :CODEMP ');
      qryConsulta.SQL.Add('  AND M.MCL_TIPMET  = :TIPMET ');


      qryConsulta.ParamByName('CODCLI').AsString:= strCodCli;
      qryConsulta.ParamByName('DTAINI').AsDate:= StrToDate(strDataIni);
      qryConsulta.ParamByName('DTAFIN').AsDate:= StrToDate(strDataFim);
      qryConsulta.ParamByName('CODEMP').AsString:= VS_strCodEmp;
      qryConsulta.ParamByName('TIPMET').AsString:= strTipMet;
      qryConsulta.Open;

      If (Not(qryConsulta.IsEmpty)) Then
      Begin

        FCodCli:= qryConsulta.FieldByName('MCL_CODCLI').AsString;
        FcodVen:= qryConsulta.FieldByName('CLI_CODVEN').AsString;
        FDatIni:= qryConsulta.FieldByName('MCL_DTAINI').AsString;
        FDatFim:= qryConsulta.FieldByName('MCL_DTAFIN').AsString;
        FCodMar:= qryConsulta.FieldByName('MCL_CODMAR').AsString;
        FCodLin:= qryConsulta.FieldByName('MCL_CODGRU').AsString;
        FCodFor:= qryConsulta.FieldByName('MCL_CODFOR').AsString;
        FCodDep:= qryConsulta.FieldByName('MCL_CODDEP').AsString;
        FTipMet:= qryConsulta.FieldByName('MCL_TIPMET').AsString;
        FValMet:= qryConsulta.FieldByName('MCL_VALMET').AsFloat;
        FPerDes:= qryConsulta.FieldByName('MCL_VALDES').AsFloat;

        Result:= True;
      End;
    End
    Else
    Begin
      FCodCli:= '';
      FcodVen:= '';
      FDatIni:= '';
      FDatFim:= '';
      FCodMar:= '';
      FCodLin:= '';
      FCodFor:= '';
      FCodDep:= '';
      FTipMet:= '';
      FValMet:= 0;
      FPerDes:= 0;
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;

end;

procedure TfrmImportCadMetasClientes.FormCreate(Sender: TObject);
begin
  inherited;
  edtPath.Dialog.Dialog.Filter := 'Arquivos Suportados|*.xls;*.xlsx;*.csv';

end;

function TfrmImportCadMetasClientes.fTemTitulo: boolean;
var
  intValDef: Integer;
begin
  If Not blnArqCsv Then
  Begin
    If Trim(Excel.Range[cCodCli + IntToStr(1)].Value) <> '' Then
      Result := not TryStrToInt(Trim(Excel.Range[cCodCli + IntToStr(1)].Value), intValDef)
    Else
      Result := False;
  End
  Else
  Begin
    If objValidaExcel.fGetValueCSV(0, cCodCli) <> '' Then
      Result := not TryStrToInt(Trim(objValidaExcel.fGetValueCSV(0, cCodCli)), intValDef)
    Else
      Result := False;
  End
end;

function TfrmImportCadMetasClientes.fValidaTipoMet(strValor: Variant;
  inLinhaAtual: Integer; var strMensagem: String): Boolean;
begin
  strMensagem := 'O Tipo de meta deve ser "V" ou "L"';
  Result := AnsiMatchText(strValor, ['V','L']);
end;

procedure TfrmImportCadMetasClientes.pAtualizaInfoValidador;
begin
  PnlInfo.Caption := objValidaExcel.TempoExtimado;
end;

procedure TfrmImportCadMetasClientes.pCriarDataSet(
  FImportMetasClientes: TfrmImportCadMetasClientesConfirma);
begin
  FImportMetasClientes.cdsDadosIns.CreateDataSet;
  FImportMetasClientes.cdsDadosUpd.CreateDataSet;
  FImportMetasClientes.cdsDadosIns.EmptyDataSet;
  FImportMetasClientes.cdsDadosUpd.EmptyDataSet;

  If (Not(FImportMetasClientes.cdsVendedorNaoImportadaRelatorio.Active)) Then
    FImportMetasClientes.cdsVendedorNaoImportadaRelatorio.CreateDataSet;

  If (Not(FImportMetasClientes.cdsMarcaNaoImportadaRelatorio.Active)) Then
    FImportMetasClientes.cdsMarcaNaoImportadaRelatorio.CreateDataSet;

  If (Not(FImportMetasClientes.cdsFornecedorNaoImportadaRelatorio.Active)) Then
    FImportMetasClientes.cdsFornecedorNaoImportadaRelatorio.CreateDataSet;

  If (Not(FImportMetasClientes.cdsClienteNaoImportadaRelatorio.Active)) Then
    FImportMetasClientes.cdsClienteNaoImportadaRelatorio.CreateDataSet;

  If (Not(FImportMetasClientes.cdsGrupoNaoImportadaRelatorio.Active)) Then
    FImportMetasClientes.cdsGrupoNaoImportadaRelatorio.CreateDataSet;

  If (Not(FImportMetasClientes.cdsDepartamentoNaoImportadaRelatorio.Active)) Then
    FImportMetasClientes.cdsDepartamentoNaoImportadaRelatorio.CreateDataSet;

end;

procedure TfrmImportCadMetasClientes.pFormataCampos(
  FImportMetasClientes: TfrmImportCadMetasClientesConfirma);
begin
   TFloatField(FImportMetasClientes.cdsDadosIns.FieldByName('VALMET')).DisplayFormat := '###,###,##0.00';
   TFloatField(FImportMetasClientes.cdsDadosIns.FieldByName('PERDES')).DisplayFormat := '###,###,##0.00';

    TFloatField(FImportMetasClientes.cdsDadosUpd.FieldByName('VALMET')).DisplayFormat := '###,###,##0.00';
    TFloatField(FImportMetasClientes.cdsDadosUpd.FieldByName('PERDES')).DisplayFormat := '###,###,##0.00';
    TFloatField(FImportMetasClientes.cdsDadosUpd.FieldByName('VALMET_NOVO')).DisplayFormat := '###,###,##0.00';
    TFloatField(FImportMetasClientes.cdsDadosUpd.FieldByName('PERDES_NOVO')).DisplayFormat := '###,###,##0.00';

end;

procedure TfrmImportCadMetasClientes.pValidaCampoVazio(strInfo: Variant);
Begin
  If (strInfo = '') Then
    raise Exception.Create('Campo não possui informação!');
End;

procedure TfrmImportCadMetasClientes.pVerificaDataPreenchida(strDataIni,
  strDataFim: String);
  Var
    blnResult: Boolean;
begin

  blnResult:= ( fEmptyStr(strDataIni) Or fEmptyStr(strDataFim) );

  If (Not(blnResult)) Then
  Begin
    raise Exception.Create('Campo Data não preenchido!');
  End;
end;

procedure TfrmImportCadMetasClientes.pValidaCampoPreenchido(strInfo: Variant);
Begin
  If (strInfo <> '') Then
    raise Exception.Create('Campo possui informação!');
End;

procedure TfrmImportCadMetasClientes.pValidaTrueFalse(blnCampoEmBranco: Boolean);
Begin
  If (blnCampoEmBranco) Then
    raise Exception.Create('Informação verdadeira!');
End;

procedure TfrmImportCadMetasClientes.pInsereItensCDS(intLinha: integer;
  FImportMetasClientes: TfrmImportCadMetasClientesConfirma);
Var
  I: Integer;
  qryCliente: TUniQuery;
  arrCodCli: Array Of String;
  blnCampoEmBranco: Boolean;
begin

  I:= 0;

  If Not(fEmptyStr(objValidaExcel.fGetValueCSV(intLinha, cCodCli))) Then
  Begin
    SetLength(arrCodCli, 1);
    arrCodCli[I]:= objValidaExcel.fGetValueCSV(intLinha, cCodCli);
  End
  Else
  Begin
    qryCliente:= fCriaQuery(Nil);
    Try

      qryCliente.Close;
      qryCliente.SQL.Clear;
      qryCliente.SQL.Add('SELECT CLI_CODCLI FROM CADCLI WHERE CLI_CODVEN = :CODVEN');
      qryCliente.ParamByName('CODVEN').AsString:= objValidaExcel.fGetValueCSV(intLinha, cCodVen);
      qryCliente.Open;

      qryCliente.First;
      While Not(qryCliente.Eof) Do
      Begin
        Inc(I);
        SetLength(arrCodCli, I);
        arrCodCli[I-1]:= qryCliente.FieldByName('CLI_CODCLI').AsString;
        qryCliente.Next;
      End;
    Finally
      FreeAndNil(qryCliente);
    End;

  End;

  For I := 0 To Length(arrCodCli) - 1 Do
  Begin

    If (Not(fMetaEncontradaNoBanco(arrCodCli[I],
                                   objValidaExcel.fGetValueCSV(intLinha, cTipMet).ToUpper,
                                   objValidaExcel.fGetValueCSV(intLinha, cDatIni),
                                   objValidaExcel.fGetValueCSV(intLinha, cDatFim)))) Then
    Begin

      Begin
        FImportMetasClientes.cdsDadosIns.Insert;

        FImportMetasClientes.cdsDadosIns.FieldByName('MARCADO').Value := 1;

        Try
          pValidaCampoVazio(fConvetVazioToNull(arrCodCli[I]));
          FImportMetasClientes.cdsDadosIns.FieldByName('NOMCLI').AsString  := fRetNomCliente(fConvetVazioToNull(arrCodCli[I]));

          Try
            pValidaCampoVazio(FImportMetasClientes.cdsDadosIns.FieldByName('NOMCLI').AsString);
            FImportMetasClientes.cdsDadosIns.FieldByName('CODCLI').AsString  := fConvetVazioToNull(arrCodCli[I]);

          Except
            on E: Exception do
            Begin
              FImportMetasClientes.pIncluiClienteNaoImportada(FImportMetasClientes.cdsDadosIns.FieldByName('CODCLI').AsString);

            End;
          End;

        Except
          on E: Exception do
          Begin

          End;
        End;


        Try
          pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cCodVen));
          FImportMetasClientes.cdsDadosIns.FieldByName('NOMVEN').AsString  := fRetNomVendRep(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodVen)));

          Try
            pValidaCampoVazio(FImportMetasClientes.cdsDadosIns.FieldByName('NOMVEN').AsString);
            FImportMetasClientes.cdsDadosIns.FieldByName('CODVEN').AsString  := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodVen));

          Except
            on E: Exception do
            Begin
              FImportMetasClientes.pIncluiVendedorNaoImportada(FImportMetasClientes.cdsDadosIns.FieldByName('CODVEN').AsString);

            End;
          End;


        Except
          on E: Exception do
          Begin

          End;
        End;


        Try
          pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cDatIni));
          FImportMetasClientes.cdsDadosIns.FieldByName('DATINI').AsString  := objValidaExcel.fGetValueCSV(intLinha, cDatIni)

        Except
          on E: Exception do
          Begin
            FImportMetasClientes.cdsDadosIns.FieldByName('DATINI').AsString  := '';
          End;
        End;


        Try
          pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cDatFim));
          FImportMetasClientes.cdsDadosIns.FieldByName('DATFIM').AsString  := objValidaExcel.fGetValueCSV(intLinha, cDatFim)

        Except
          on E: Exception do
          Begin
            FImportMetasClientes.cdsDadosIns.FieldByName('DATFIM').AsString:= '';
          End;
        End;


        Try
          pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cCodMar));
          FImportMetasClientes.cdsDadosIns.FieldByName('NOMMAR').AsString  := fRetNomeMarca(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodMar)));

          Try
            pValidaCampoVazio(FImportMetasClientes.cdsDadosIns.FieldByName('NOMMAR').AsString);
            FImportMetasClientes.cdsDadosIns.FieldByName('CODMAR').AsString  := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodMar));

          Except
            on E: Exception do
            Begin
              FImportMetasClientes.pIncluiMarcaNaoImportada(FImportMetasClientes.cdsDadosIns.FieldByName('CODMAR').AsString);

            End;
          End;


        Except
          on E: Exception do
          Begin

          End;
        End;

        Try
          pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cCodLin));
          Begin
            FImportMetasClientes.cdsDadosIns.FieldByName('NOMGRU').AsString  := fRetNomeLinhaGrupo(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodLin)));
            Try
              pValidaCampoVazio(FImportMetasClientes.cdsDadosIns.FieldByName('NOMGRU').AsString);
              FImportMetasClientes.pIncluiGrupoNaoImportada(FImportMetasClientes.cdsDadosIns.FieldByName('CODGRU').AsString);
              FImportMetasClientes.cdsDadosIns.FieldByName('CODGRU').AsString  := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodLin));
            Except
              on E: Exception do
              Begin
                FImportMetasClientes.pIncluiGrupoNaoImportada(FImportMetasClientes.cdsDadosIns.FieldByName('CODGRU').AsString);
              End;
            End;


          End;
        Except
          on E: Exception do
          Begin

          End;
        End;

        Try
          pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cCodFor));
          FImportMetasClientes.cdsDadosIns.FieldByName('NOMFOR').AsString  := fRetNomFornecedor(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodFor)));

          Try
            pValidaCampoVazio(FImportMetasClientes.cdsDadosIns.FieldByName('NOMFOR').AsString);
            FImportMetasClientes.cdsDadosIns.FieldByName('CODFOR').AsString  := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodFor));

          Except
            on E: Exception do
            Begin
              FImportMetasClientes.pIncluiFornecedorNaoImportada(FImportMetasClientes.cdsDadosIns.FieldByName('CODFOR').AsString);
            End;
          End;

        Except
          on E: Exception do
          Begin

          End;
        End;

        Try
          pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cCodDep));
          FImportMetasClientes.cdsDadosIns.FieldByName('NOMDEP').AsString  := fRetNomDep(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodDep)));

          Try
            pValidaCampoVazio(FImportMetasClientes.cdsDadosIns.FieldByName('NOMDEP').AsString);
            FImportMetasClientes.cdsDadosIns.FieldByName('CODDEP').AsString  := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodDep));

          Except
            on E: Exception do
            Begin
              FImportMetasClientes.pIncluiDepartamentoNaoImportada(FImportMetasClientes.cdsDadosIns.FieldByName('CODDEP').AsString);
            End;
          End;


        Except
          on E: Exception do
          Begin

          End;
        End;

        Try
          pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cTipMet));
          FImportMetasClientes.cdsDadosIns.FieldByName('TIPMET').AsString  := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cTipMet).ToUpper);
        Except
          on E: Exception do
          Begin

          End;
        End;

        Try
          pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cValMet));
          FImportMetasClientes.cdsDadosIns.FieldByName('VALMET').AsString  := AnsiReplaceStr(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cValMet)), '.', '');
        Except
          on E: Exception do
          Begin

          End;
        End;

        Try
          pValidaCampoVazio(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cPerDes)));
          FImportMetasClientes.cdsDadosIns.FieldByName('PERDES').AsString  := AnsiReplaceStr(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cPerDes)), '.', '');
        Except
          on E: Exception do
          Begin

          End;
        End;

        Try
          pVerificaDataPreenchida(FImportMetasClientes.cdsDadosIns.FieldByName('DATINI').AsString, FImportMetasClientes.cdsDadosIns.FieldByName('DATFIM').AsString);

          Try
            pValidaCampoPreenchido(FImportMetasClientes.cdsDadosIns.FieldByName('NOMVEN').AsString);

          Except
            on E: Exception do
            Begin
              FImportMetasClientes.pIncluiVendedorNaoImportada(FImportMetasClientes.cdsDadosIns.FieldByName('CODVEN').AsString);
            End;
          End;

          Try
            pValidaCampoPreenchido(FImportMetasClientes.cdsDadosIns.FieldByName('NOMCLI').AsString);

          Except
            on E: Exception do
            Begin
              FImportMetasClientes.pIncluiClienteNaoImportada(FImportMetasClientes.cdsDadosIns.FieldByName('CODCLI').AsString);
            End;
          End;

          Try
            pValidaCampoPreenchido(FImportMetasClientes.cdsDadosIns.FieldByName('NOMMAR').AsString);

          Except
            on E: Exception do
            Begin
              FImportMetasClientes.pIncluiMarcaNaoImportada(FImportMetasClientes.cdsDadosIns.FieldByName('CODMAR').AsString);
            End;
          End;

          Try
            pValidaCampoPreenchido(FImportMetasClientes.cdsDadosIns.FieldByName('NOMGRU').AsString);

          Except
            on E: Exception do
            Begin
              FImportMetasClientes.pIncluiGrupoNaoImportada(FImportMetasClientes.cdsDadosIns.FieldByName('CODGRU').AsString);
            End;
          End;

          Try
            pValidaCampoPreenchido(FImportMetasClientes.cdsDadosIns.FieldByName('NOMFOR').AsString);

          Except
            on E: Exception do
            Begin
              FImportMetasClientes.pIncluiGrupoNaoImportada(FImportMetasClientes.cdsDadosIns.FieldByName('CODFOR').AsString);
            End;
          End;

          Try
            pValidaCampoPreenchido(FImportMetasClientes.cdsDadosIns.FieldByName('NOMDEP').AsString);

          Except
            on E: Exception do
            Begin
              FImportMetasClientes.pIncluiDepartamentoNaoImportada(FImportMetasClientes.cdsDadosIns.FieldByName('CODDEP').AsString);
            End;
          End;


        Except
          on E: Exception do
          Begin

          End;

        End;

        blnCampoEmBranco:= (fEmptyStr(FImportMetasClientes.cdsDadosIns.FieldByName('NOMCLI').AsString) Or
                            fEmptyStr(FImportMetasClientes.cdsDadosIns.FieldByName('DATINI').AsString) Or
                            fEmptyStr(FImportMetasClientes.cdsDadosIns.FieldByName('DATFIM').AsString));

        Try
          pValidaTrueFalse(blnCampoEmBranco);
          FImportMetasClientes.cdsDadosIns.Post;
        Except
          on E: Exception do
          Begin
            FImportMetasClientes.cdsDadosIns.Cancel;
          End;
        End;

      End;

    End
    Else
    Begin

      Begin
        FImportMetasClientes.cdsDadosUpd.Insert;

        FImportMetasClientes.cdsDadosUpd.FieldByName('MARCADO').Value := 1;

        FImportMetasClientes.cdsDadosUpd.FieldByName('CODCLI').AsString  := fConvetVazioToNull(arrCodCli[I]);
        FImportMetasClientes.cdsDadosUpd.FieldByName('NOMCLI').AsString  := fRetNomCliente(fConvetVazioToNull(arrCodCli[I]));

        Try
          pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cCodVen));
          FImportMetasClientes.cdsDadosUpd.FieldByName('NOMVEN').AsString  := fRetNomVendRep(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodVen)));
          Try
            pValidaCampoVazio(FImportMetasClientes.cdsDadosUpd.FieldByName('NOMVEN').AsString);
            FImportMetasClientes.cdsDadosUpd.FieldByName('CODVEN').AsString  := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodVen));

          Except
            on E: Exception do
            Begin
              FImportMetasClientes.pIncluiVendedorNaoImportada(FImportMetasClientes.cdsDadosUpd.FieldByName('CODVEN').AsString);
            End;
          End;


        Except
          on E: Exception do
          Begin

          End;

        End;


        Try
          pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cDatIni));
          FImportMetasClientes.cdsDadosUpd.FieldByName('DATINI').AsString  := objValidaExcel.fGetValueCSV(intLinha, cDatIni);
        Except
          on E: Exception do
          Begin
            FImportMetasClientes.cdsDadosUpd.FieldByName('DATINI').AsString:= '';
          End;

        End;

        Try
          pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cDatFim));
          FImportMetasClientes.cdsDadosUpd.FieldByName('DATFIM').AsString  := objValidaExcel.fGetValueCSV(intLinha, cDatFim)
        Except
          on E: Exception do
          Begin
            FImportMetasClientes.cdsDadosUpd.FieldByName('DATFIM').AsString:= '';
          End;

        End;

        FImportMetasClientes.cdsDadosUpd.FieldByName('CODMAR').AsString  := FCodMar;
        FImportMetasClientes.cdsDadosUpd.FieldByName('NOMMAR').AsString  := fRetNomeMarca(FCodMar);
        FImportMetasClientes.cdsDadosUpd.FieldByName('CODGRU').AsString  := FCodLin;
        FImportMetasClientes.cdsDadosUpd.FieldByName('NOMGRU').AsString  := fRetNomeLinhaGrupo(FCodLin);
        FImportMetasClientes.cdsDadosUpd.FieldByName('CODFOR').AsString  := FCodFor;
        FImportMetasClientes.cdsDadosUpd.FieldByName('NOMFOR').AsString  := fRetNomFornecedor(FCodFor);
        FImportMetasClientes.cdsDadosUpd.FieldByName('CODDEP').AsString  := FCodDep;
        FImportMetasClientes.cdsDadosUpd.FieldByName('NOMDEP').AsString  := fRetNomDep(FCodDep);
        FImportMetasClientes.cdsDadosUpd.FieldByName('TIPMET').AsString  := FTipMet;
        FImportMetasClientes.cdsDadosUpd.FieldByName('VALMET').AsString  := AnsiReplaceStr(FormatFloat('#,##0.00', FValMet),'.','');
        FImportMetasClientes.cdsDadosUpd.FieldByName('PERDES').AsString  := AnsiReplaceStr(FormatFloat('#,##0.00', FPerDes),'.','');


        Try
          pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cCodMar));
          FImportMetasClientes.cdsDadosUpd.FieldByName('NOMMAR_NOVO').AsString  := fRetNomeMarca(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodMar)));

          Try
            pValidaCampoVazio(FImportMetasClientes.cdsDadosUpd.FieldByName('NOMMAR_NOVO').AsString);
            FImportMetasClientes.cdsDadosUpd.FieldByName('CODMAR_NOVO').AsString  := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodMar));

          Except
            on E: Exception do
            Begin
              FImportMetasClientes.pIncluiMarcaNaoImportada(FImportMetasClientes.cdsDadosUpd.FieldByName('CODMAR_NOVO').AsString);
            End;

          End;

        Except
          on E: Exception do
          Begin

          End;

        End;


        Try
          pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cCodLin));
          FImportMetasClientes.cdsDadosUpd.FieldByName('NOMGRU_NOVO').AsString  := fRetNomeLinhaGrupo(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodLin)));

          Try
            pValidaCampoVazio(FImportMetasClientes.cdsDadosUpd.FieldByName('NOMGRU_NOVO').AsString);
            FImportMetasClientes.cdsDadosUpd.FieldByName('CODGRU_NOVO').AsString  := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodLin));

          Except
            on E: Exception do
            Begin
              FImportMetasClientes.pIncluiGrupoNaoImportada(FImportMetasClientes.cdsDadosUpd.FieldByName('CODGRU_NOVO').AsString);
            End;

          End;

        Except
          on E: Exception do
          Begin

          End;

        End;


        Try
          pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cCodFor));
          FImportMetasClientes.cdsDadosUpd.FieldByName('NOMFOR_NOVO').AsString  := fRetNomFornecedor(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodFor)));

          Try
            pValidaCampoVazio(FImportMetasClientes.cdsDadosUpd.FieldByName('NOMFOR_NOVO').AsString);
            FImportMetasClientes.cdsDadosUpd.FieldByName('CODFOR_NOVO').AsString  := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodFor));

          Except
            on E: Exception do
            Begin
              FImportMetasClientes.pIncluiFornecedorNaoImportada(FImportMetasClientes.cdsDadosUpd.FieldByName('CODFOR_NOVO').AsString);
            End;

          End;

        Except
          on E: Exception do
          Begin

          End;

        End;

        Try
          pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cCodDep));
          FImportMetasClientes.cdsDadosUpd.FieldByName('NOMDEP_NOVO').AsString  := fRetNomDep(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodDep)));

          Try
            pValidaCampoVazio(FImportMetasClientes.cdsDadosUpd.FieldByName('NOMDEP_NOVO').AsString);
            FImportMetasClientes.cdsDadosUpd.FieldByName('CODDEP_NOVO').AsString  := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodDep));

          Except
            on E: Exception do
            Begin
              FImportMetasClientes.pIncluiDepartamentoNaoImportada(FImportMetasClientes.cdsDadosUpd.FieldByName('CODDEP_NOVO').AsString);
            End;

          End;
        Except
          on E: Exception do
          Begin

          End;

        End;


        Try
          pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cTipMet));
          FImportMetasClientes.cdsDadosUpd.FieldByName('TIPMET_NOVO').AsString  := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cTipMet).ToUpper);
        Except
          on E: Exception do
          Begin

          End;

        End;

        Try
          pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cValMet));
          FImportMetasClientes.cdsDadosUpd.FieldByName('VALMET_NOVO').AsString  := AnsiReplaceStr(FormatFloat('#,##0.00', fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cValMet))),'.','');
        Except
          on E: Exception do
          Begin

          End;

        End;

        Try
          pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cPerDes));
          FImportMetasClientes.cdsDadosUpd.FieldByName('PERDES_NOVO').AsString  := AnsiReplaceStr(FormatFloat('#,##0.00', fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cPerDes))),'.','');
        Except
          on E: Exception do
          Begin

          End;

        End;

        Try
          pVerificaDataPreenchida(FImportMetasClientes.cdsDadosUpd.FieldByName('DATINI').AsString, FImportMetasClientes.cdsDadosUpd.FieldByName('DATFIM').AsString);

          Try
            pValidaCampoPreenchido(FImportMetasClientes.cdsDadosUpd.FieldByName('NOMVEN').AsString);

          Except
            on E: Exception do
            Begin
              FImportMetasClientes.pIncluiVendedorNaoImportada(FImportMetasClientes.cdsDadosUpd.FieldByName('CODVEN').AsString);
            End;
          End;

          Try
            pValidaCampoPreenchido(FImportMetasClientes.cdsDadosUpd.FieldByName('NOMCLI').AsString);

          Except
            on E: Exception do
            Begin
              FImportMetasClientes.pIncluiClienteNaoImportada(FImportMetasClientes.cdsDadosUpd.FieldByName('CODCLI').AsString);
            End;
          End;

          Try
            pValidaCampoPreenchido(FImportMetasClientes.cdsDadosUpd.FieldByName('NOMMAR').AsString);

          Except
            on E: Exception do
            Begin
              FImportMetasClientes.pIncluiMarcaNaoImportada(FImportMetasClientes.cdsDadosUpd.FieldByName('CODMAR').AsString);
            End;
          End;

          Try
            pValidaCampoPreenchido(FImportMetasClientes.cdsDadosUpd.FieldByName('NOMGRU').AsString);

          Except
            on E: Exception do
            Begin
              FImportMetasClientes.pIncluiGrupoNaoImportada(FImportMetasClientes.cdsDadosUpd.FieldByName('CODGRU').AsString);
            End;
          End;

          Try
            pValidaCampoPreenchido(FImportMetasClientes.cdsDadosUpd.FieldByName('NOMFOR').AsString);

          Except
            on E: Exception do
            Begin
              FImportMetasClientes.pIncluiGrupoNaoImportada(FImportMetasClientes.cdsDadosUpd.FieldByName('CODFOR').AsString);
            End;
          End;

          Try
            pValidaCampoPreenchido(FImportMetasClientes.cdsDadosUpd.FieldByName('NOMDEP').AsString);

          Except
            on E: Exception do
            Begin
              FImportMetasClientes.pIncluiDepartamentoNaoImportada(FImportMetasClientes.cdsDadosUpd.FieldByName('CODDEP').AsString);
            End;
          End;
        Except
          on E: Exception do
          Begin

          End;

        End;

        blnCampoEmBranco:= (fEmptyStr(FImportMetasClientes.cdsDadosUpd.FieldByName('NOMCLI').AsString) Or
                            fEmptyStr(FImportMetasClientes.cdsDadosUpd.FieldByName('DATINI').AsString) Or
                            fEmptyStr(FImportMetasClientes.cdsDadosUpd.FieldByName('DATFIM').AsString));

        Try
          pValidaTrueFalse(blnCampoEmBranco);
          FImportMetasClientes.cdsDadosUpd.Post;
        Except
          on E: Exception do
          Begin
            FImportMetasClientes.cdsDadosUpd.Cancel;
          End;
        End;


      End;

    End;
  End;
end;

procedure TfrmImportCadMetasClientes.pPreparaValidador;
begin
  If Not Assigned(objValidaExcel) Then
    Exit;
  objValidaExcel.FAtualizaStatus := pAtualizaInfoValidador;
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesCODCLI, cCodCli, 8, True,  False, 'CADCLI', 'CLI_CODCLI'));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoInt(cDesCODCLI, cCodCli));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesCODVEN, cCodVen, 3, True,  False, 'CADOPE', 'OPE_CODOPE'));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoInt(cDesCODVEN, cCodVen));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesDatIni, cDatIni, 10, True, False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesDatFim, cDatFim, 10, True,False, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesCodMar, cCodMar, 6, True, False, 'CADMAR', 'MAR_CODMAR'));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoInt(cDesCodMar, cCodMar));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesCodLin, cCodLin, 6, True, False, 'CADGRU', 'GRU_CODGRU'));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoInt(cDesCodLin, cCodLin));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesCodFor, cCodFor, 8, True, False, 'CADFOR', 'FOR_CODFOR'));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoInt(cDesCodFor, cCodFor));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesCodDep, cCodDep, 3, True, False, 'CADDEP', 'DEP_CODIGO'));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoInt(cDesCodDep, cCodDep));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesTipMet, cTipMet, 1, True, True, '', '', False, fValidaTipoMet));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesValMet, cValMet));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesPerDes, cPerDes));
end;

end.
