unit untExportacaoEtiquetasEletronicasCSV;

interface

uses Vcl.ComCtrls, Vcl.Forms, Data.DB, System.Classes, Vcl.Dialogs, System.SysUtils,
  untIExportacaoEtiquetasEletronicas, untFuncoesSimples, Uni, UniClientDataSet, untTypesSistema;

type
  TArquivoCSV = class
  strict private
    FArquivoCSV: TStringList;
    FNomeArquivo: String;
    function fFormataValor(strValor: String): String;
    function fUltimaLinha: String;
  public
    constructor Create(strNomeArquivo: String = '');
    destructor Destroy; override;

    procedure AddValor(strValor: String);
    procedure NovaLinha;
    procedure SalvarArquivo;
  End;

  TExportacaoEtiquetasEletronicasCSV = class(TInterfacedObject, IExportacaoEtiquetasEletronicas)
  private
    FArqCSV: TArquivoCSV;
    FDtaIniPromocao: String;
    FDtaFinPromocao: String;
    FProdutoEmPromocao: String;

    function fRetornarSaldoEmpresaCD(const strCodIte, strCodEmp: String): Double;
    procedure pDefinirSeOItemEstaEmPromocao(const strCodIte, strCodEmp: String);
    function fPrimeiraTabPreco: String;
    function fRetornaPrecoPromocao(const strCodIte, strCodEmp: String): Double;
    function fTexto(strValor: String; intTamanho: Integer): String;
    procedure pAplicarFiltroEmpresaCdsProduto(cdsProdutos: TUniClientDataSet; arrCodEmpEtiEle: TConsultasArray);

    procedure pCabecalho;
    procedure pRegistro(DataSet: TDataSet; strNomeArq: string);
  public
    function fGerarArquivo(strPath: String; DataSet: TDataSet; pgbProgresso: TProgressBar; arrCodEmpEtiEle: TConsultasArray; strNomeArq, strFiltro: string): Boolean;
    class function New(): IExportacaoEtiquetasEletronicas;
  end;

implementation

{ TExportacaoEtiquetasEletronicasCSV }

uses untCadPro;

function TExportacaoEtiquetasEletronicasCSV.fGerarArquivo(strPath: String; DataSet: TDataSet; pgbProgresso: TProgressBar; arrCodEmpEtiEle: TConsultasArray; strNomeArq, strFiltro: string): Boolean;
var
  cdsProdutos: TUniClientDataSet;
  strCodEmp: String;
begin
  pgbProgresso.Position := 0;
  Try
    DataSet.Filtered := False;
    cdsProdutos := fCriaClientDatset(DataSet, False, Nil, False);
    pAplicarFiltroEmpresaCdsProduto(cdsProdutos, arrCodEmpEtiEle);

    cdsProdutos.Filtered := False;
    cdsProdutos.Filter := cdsProdutos.Filter + IIF(not fEmptyStr(cdsProdutos.Filter), ' AND ' + strFiltro, strFiltro);
    cdsProdutos.Filtered := True;

    cdsProdutos.IndexFieldNames := 'ITEGER_CODEMP;ITE_DESITE';
    DataSet.Filtered := True;

    pgbProgresso.Max := cdsProdutos.RecordCount;

    strCodEmp := '';

    cdsProdutos.First;
    While Not cdsProdutos.Eof Do
    Begin

      If (Not fEmptyStr(strCodEmp)) then
      begin
        If (strCodEmp <> cdsProdutos.FieldByName('ITEGER_CODEMP').AsString) Then
        Begin
          strCodEmp := '';
          FArqCSV.SalvarArquivo;
          FreeAndNil(FArqCSV);
        End;
      end;

      If fEmptyStr(strCodEmp) Then
      Begin
        FArqCSV := TArquivoCSV.Create(strPath + '\' + strNomeArq + '.csv');
        pCabecalho;
      End;

      pRegistro(cdsProdutos, strNomeArq);

      strCodEmp := cdsProdutos.FieldByName('ITEGER_CODEMP').AsString;

      pgbProgresso.StepBy(1);
      Application.ProcessMessages; //so para testes

      cdsProdutos.Next;
    End;

    If (Not fEmptyStr(strCodEmp)) Then
    Begin
      FArqCSV.SalvarArquivo;
      FreeAndNil(FArqCSV);
    End;

    fMensagem('', 'Arquivo gerado com sucesso!', ['&O k']);
    pgbProgresso.Position := 0;
    Result := True;
  Finally
    FreeAndNil(cdsProdutos);
  End;
end;

function TExportacaoEtiquetasEletronicasCSV.fPrimeiraTabPreco: String;
begin
  Result := IntToStr(Pos('S', VS_strTabPrc));
end;

function TExportacaoEtiquetasEletronicasCSV.fRetornaPrecoPromocao(
  const strCodIte, strCodEmp: String): Double;
var
  fltPreCus,
  fltPreVen,
  fltComVar,
  fltComAta,
  fltComDis,
  fltQtdDis,
  fltDesF07: Double;
  strComPro: String;
  strCodPro: String;
  blnParticiona,
  blnPromo: Boolean;
begin
  Result := 0;

  If Not (fRetornaPrecosPromocao(strCodIte, '',
          VS_Date, 1, 0, 0, 0, fltPreCus, fltPreVen, fltComVar, fltComAta,
          fltComDis, fltQtdDis, fltDesF07, strComPro, strCodPro, blnParticiona, blnPromo, '', '')) Then
    Exit;

  Result := fltPreVen;
end;

function TExportacaoEtiquetasEletronicasCSV.fRetornarSaldoEmpresaCD(
  const strCodIte, strCodEmp: String): Double;
var
  strEmp_CD: String;
begin
  strEmp_CD := fCfgSis('EMP_CD', varString, strCodEmp);
  Result := fCampoTabela('ITE_SALDOS', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [strCodIte, strEmp_CD]);
end;

function TExportacaoEtiquetasEletronicasCSV.fTexto(strValor: String;
  intTamanho: Integer): String;
begin
  Result := Trim(Copy(strValor, 1, intTamanho));
end;

procedure TExportacaoEtiquetasEletronicasCSV.pAplicarFiltroEmpresaCdsProduto(
  cdsProdutos: TUniClientDataSet; arrCodEmpEtiEle: TConsultasArray);
var
  intCont: Integer;
begin

  If Length(arrCodEmpEtiEle) = 0 Then
    Exit;

  For intCont := 0 To High(arrCodEmpEtiEle) Do
  Begin
    If arrCodEmpEtiEle[intCont].strCodigo = VS_strCodEmp Then
    Begin
      Exit;
    End;
  End;

  cdsProdutos.Filter := 'ITEGER_CODEMP <> ' + QuotedStr(VS_strCodEmp);
  cdsProdutos.Filtered := True;

end;

procedure TExportacaoEtiquetasEletronicasCSV.pCabecalho;
begin
  FArqCSV.NovaLinha;
  FArqCSV.AddValor('"cliente"');
  FArqCSV.AddValor('"idloja"');
  FArqCSV.AddValor('"codbarras"');
  FArqCSV.AddValor('"coditem"');
  FArqCSV.AddValor('"descricao"');
  FArqCSV.AddValor('"descprim"');
  FArqCSV.AddValor('"descsec"');
  FArqCSV.AddValor('"unidade"');
  FArqCSV.AddValor('"quant"');
  FArqCSV.AddValor('"origem"');
  FArqCSV.AddValor('"fabricante"');
  FArqCSV.AddValor('"tipo"');
  FArqCSV.AddValor('"qrcode"');
  FArqCSV.AddValor('"nfc"');
  FArqCSV.AddValor('"imagem"');
  FArqCSV.AddValor('"estoqueloja"');
  FArqCSV.AddValor('"estoquecd"');
  FArqCSV.AddValor('"localizacao"');
  FArqCSV.AddValor('"exposicaofrente"');
  FArqCSV.AddValor('"exposicaofundo"');
  FArqCSV.AddValor('"planograma"');
  FArqCSV.AddValor('"promocao"');
  FArqCSV.AddValor('"depor"');
  FArqCSV.AddValor('"sazonal"');
  FArqCSV.AddValor('"ruptura"');
  FArqCSV.AddValor('"fidelidade"');
  FArqCSV.AddValor('"preconormal"');
  FArqCSV.AddValor('"precopromocao"');
  FArqCSV.AddValor('"precode"');
  FArqCSV.AddValor('"precopor"');
  FArqCSV.AddValor('"precooferta"');
  FArqCSV.AddValor('"precofidelidade"');
  FArqCSV.AddValor('"precounidade"');
  FArqCSV.AddValor('"datavalidade"');
  FArqCSV.AddValor('"datainicio"');
  FArqCSV.AddValor('"datafim"');
  FArqCSV.AddValor('"dataarq"');
  FArqCSV.AddValor('"horaarq"');
  FArqCSV.AddValor('"loteitem"');
  FArqCSV.AddValor('"nomearq"');

end;

procedure TExportacaoEtiquetasEletronicasCSV.pDefinirSeOItemEstaEmPromocao(
  const strCodIte, strCodEmp: String);
var
  qryTabela: TUniQuery;
  strCodPro: String;
begin
  FProdutoEmPromocao := 'N';
  FDtaIniPromocao := '';
  FDtaFinPromocao := '';

  Try
    qryTabela := fCriaQuery;
    strCodPro := fRetornaCodPro(strCodIte, strCodEmp, VS_Date, qryTabela);

    If Not fEmptyStr(strCodPro) Then
    Begin
      FDtaIniPromocao := DateToStr(qryTabela.FieldByName('PRO_DTAINI').AsDateTime);
      FDtaFinPromocao := DateToStr(qryTabela.FieldByName('PRO_DTAFIN').AsDateTime);
      FProdutoEmPromocao := 'S';
    End;

  Finally
    FreeAndNil(qryTabela);
  End;
end;

procedure TExportacaoEtiquetasEletronicasCSV.pRegistro(DataSet: TDataSet; strNomeArq: string);
  var
    strCodBar: string;
begin

  strCodBar := StringReplace(DataSet.FieldByName('ITE_CODBAR').AsString, '|', '', []);
  strCodBar := StringReplace(strCodBar, '|', '', []);

  pDefinirSeOItemEstaEmPromocao(DataSet.FieldByName('ITE_CODITE').AsString, DataSet.FieldByName('EMP_CODEMP').AsString);

  FArqCSV.NovaLinha;

  FArqCSV.AddValor(fTexto(DataSet.FieldByName('EMP_NOMEMP').AsString, 60));
  FArqCSV.AddValor(fTexto(DataSet.FieldByName('EMP_CODEMP').AsString, 10));
  FArqCSV.AddValor(fTexto(strCodBar, 14));
  FArqCSV.AddValor(fTexto(DataSet.FieldByName('ITE_CODITE').AsString, 20));
  FArqCSV.AddValor(fTexto(DataSet.FieldByName('ITE_DESITE').AsString, 250));
  FArqCSV.AddValor(fTexto(DataSet.FieldByName('ITE_DESSIM').AsString, 100));
  FArqCSV.AddValor(fTexto('', 100));
  FArqCSV.AddValor(fTexto(DataSet.FieldByName('UNI_SIGUNI').AsString, 6));
  FArqCSV.AddValor(fTexto('1', 10));
  FArqCSV.AddValor(fTexto('BRASIL', 20));
  FArqCSV.AddValor(fTexto(DataSet.FieldByName('ITE_DESFAB').AsString, 20));
  FArqCSV.AddValor(fTexto(DataSet.FieldByName('GRU_DESGRU').AsString, 20));
  FArqCSV.AddValor(fTexto('', 250));
  FArqCSV.AddValor(fTexto('', 250));
  FArqCSV.AddValor(fTexto('', 10));
  FArqCSV.AddValor(fTexto(FloatToStr(DataSet.FieldByName('ITE_SALDOS').AsFloat), 10));
  FArqCSV.AddValor(fTexto(FloatToStr(fRetornarSaldoEmpresaCD(DataSet.FieldByName('ITE_CODITE').AsString, DataSet.FieldByName('EMP_CODEMP').AsString)), 10));
  FArqCSV.AddValor(fTexto(DataSet.FieldByName('LOCFIS').AsString, 10));
  FArqCSV.AddValor(fTexto('', 5));
  FArqCSV.AddValor(fTexto('', 5));
  FArqCSV.AddValor(fTexto('', 5));
  FArqCSV.AddValor(fTexto(FProdutoEmPromocao, 1));
  FArqCSV.AddValor(fTexto('N', 1));
  FArqCSV.AddValor(fTexto('N', 1));
  FArqCSV.AddValor(fTexto('N', 1));
  FArqCSV.AddValor(fTexto('N', 1));
  FArqCSV.AddValor(fTexto(FloatToStr(DataSet.FieldByName('ITE_PREVE' + fPrimeiraTabPreco).AsFloat), 10));
  FArqCSV.AddValor(fTexto(FloatToStr(fRetornaPrecoPromocao(DataSet.FieldByName('ITE_CODITE').AsString, DataSet.FieldByName('EMP_CODEMP').AsString)), 10));
  FArqCSV.AddValor(fTexto('0', 10));
  FArqCSV.AddValor(fTexto('0', 10));
  FArqCSV.AddValor(fTexto('0', 10));
  FArqCSV.AddValor(fTexto('0', 10));
  FArqCSV.AddValor(fTexto('0', 10));
  FArqCSV.AddValor(fTexto('', 10));
  FArqCSV.AddValor(fTexto(FDtaIniPromocao, 10));
  FArqCSV.AddValor(fTexto(FDtaFinPromocao, 10));
  FArqCSV.AddValor(fTexto(DateToStr(VS_Date), 10));
  FArqCSV.AddValor(fTexto(FormatDateTime('hh:mm:ss', fRetHoraServidor), 8));
  FArqCSV.AddValor(fTexto('', 100));
  FArqCSV.AddValor(fTexto( strNomeArq + '.csv', 100));

end;

class function TExportacaoEtiquetasEletronicasCSV.New: IExportacaoEtiquetasEletronicas;
begin
  Result := Self.Create;
end;

{ TArquivoCSV }

procedure TArquivoCSV.AddValor(strValor: String);
begin
  FArquivoCSV[FArquivoCSV.Count -1] := FArquivoCSV[FArquivoCSV.Count -1] + fFormataValor(strValor);
end;

constructor TArquivoCSV.Create(strNomeArquivo: String);
var svdCSV: TSaveDialog;
Begin
  If strNomeArquivo = '' Then
  Begin
    svdCSV := TSaveDialog.Create(Nil);
    svdCSV.Filter := 'Texto separado por ponto e vírgula|*.csv';
    svdCSV.DefaultExt := 'csv';
    Try
      If svdCSV.Execute Then
         strNomeArquivo := svdCSV.FileName
    Finally
       svdCSV.Free;
    End;
  End;

  FNomeArquivo := strNomeArquivo;
  FArquivoCSV := TStringList.Create;
  //utf8 sem BOM
  FArquivoCSV.WriteBOM := False;
end;

destructor TArquivoCSV.Destroy;
begin
  FArquivoCSV.Free;
  inherited;
end;

function TArquivoCSV.fFormataValor(strValor: String): String;
begin
  Result := strValor;

  If fUltimaLinha <> '' Then
    Result := ';' + Result;
end;

function TArquivoCSV.fUltimaLinha: String;
begin
  Result := FArquivoCSV[FArquivoCSV.Count -1];
end;

procedure TArquivoCSV.NovaLinha;
begin
  FArquivoCSV.Add('');
end;

procedure TArquivoCSV.SalvarArquivo;
begin
  If FNomeArquivo <> '' Then
  Begin
    //padrao utf8
    FArquivoCSV.SaveToFile(FNomeArquivo, TEncoding.UTF8);
    Exit;
  End;

  fMensagem('', 'Falha ao salvar arquivo, nenhum arquivo selecionado!', ['&O k']);
end;

end.

