unit untLayoutImportacaoPedidoCompra;

interface

uses vcl.Controls, Winapi.Windows, SysUtils, Classes, untZClient, uni, Data.DB,
     untTValidaExcel, UniClientDataSet, StrUtils, System.Character,
     CxProgressBar;

Type
  TTipoVisao = (tvInsercao, tvEdicao, tvVisualizacao);
  TLinha = Record
    strCodigoItem: string;
    strDescricao: string;
    strUnidade: string;
    fltEmbalagem,
    fltQuantidade,
    fltVrUnitario,
    fltDes01,
    fltDes02,
    fltDes03,
    fltdes04,
    fltDes05,
    fltDes06,
    flAlqIPI,
    fltValIPI,
    fltAqlSub,
    fltValSub,
    fltAlqImpostoImportacao,
    fltValImpostoImportacao,
    fltAqlIPIImportacao,
    fltValIPIImportacao,
    fltAlqPIS,
    fltValPIS,
    fltAqlCOFINS,
    fltValCOFINS,
    fltAlqCbs,
    fltAlqIbs,
    fltAlq_Is: Double;
  End;


  TCamposLayoutUsados = Record
    blnCodigoItem,
    blnDescricao,
    blnUnidade,
    blnEmbalagem,
    blnQuantidade,
    blnVrUnitario,
    blnDes01,
    blnDes02,
    blnDes03,
    blndes04,
    blnDes05,
    blnDes06,
    blnAlqIPI,
    blnValIPI,
    blnAqlSub,
    blnValSub,
    blnAlqImpostoImportacao,
    blnValImpostoImportacao,
    blnAqlIPIImportacao,
    blnValIPIImportacao,
    blnAlqPIS,
    blnValPIS,
    blnAqlCOFINS,
    blnValCOFINS,
    blnAlqCbs,
    blnAlqIbs,
    blnAlq_Is: Boolean;
  End;


  TTipoCampo = (tpCodigoItem,
    tpDescricao,
    tpUnidade,
    tpEmbalagem,
    tpQuantidade,
    tpVrUnitario,
    tpDes01,
    tpDes02,
    tpDes03,
    tpdes04,
    tpDes05,
    tpDes06,
    tpAlqIPI,
    tpValIPI,
    tpAqlSub,
    tpValSub,
    tpAlqImpostoImportacao,
    tpValImpostoImportacao,
    tpAqlIPIImportacao,
    tpValIPIImportacao,
    tpAlqPIS,
    tpValPIS,
    tpAqlCOFINS,
    tpValCOFINS,
    tpAlqCbs,
    tpAlqIbs,
    tpAlq_Is,
    tpIndefinido);

  TAposCarregarDadosDaLinha = procedure (Linha: TLinha; CamposLayoutUsados: TCamposLayoutUsados; var PararProcessamento: Boolean) of object;

  TCampos = class
  Private
    FCampos: TZClient;
    FCodigoLayout: String;
    FQrySQL: TUniQuery;
    FDataBackup: TUniClientDataSet;
    procedure SetCodigoLayout(const Value: string);
    procedure pPreencheCamposNovo;
    procedure pIncluiCamposReforma;
    procedure pCriaEstrutura(strCodLay: String = '');
    procedure OnBeforePost(DataSet: TDataSet);

  public
    TipoVisao: TTipoVisao;
    Constructor Create;
    destructor Destroy; override;
    procedure pNovo;
    property strCodigoLayout: string read FCodigoLayout write SetCodigoLayout;
    procedure pSalva(strAutoincrem: string);
    function fGetDataSet: TDataSet;
    class function fIntegerToTipoCampo(value: integer):TTipoCampo;
    procedure  pBackup;
  End;

  TLayout = class
  Private
    FLayouts : TZClient;
    FCampos:  TCampos;
    FQrySQL: TUniQuery;
    FTipoVisao: TTipoVisao;
    procedure pSetTipoVisao(Value : TTipoVisao);
  public
    constructor Create;
    destructor Destroy; override;
    procedure  pSetLayout(strCodLayout: string = '');
    procedure pNovo();
    procedure pSalva;
    function fGetDataSet: TDataSet;
    function fGetCamposDataSet: TDataSet;
    procedure pRemoveLayout;
    property TipoVisao: TTipoVisao read FTipoVisao write pSetTipoVisao;
    procedure  pBackup;
  End;


  TImportaPlanilhaPedidoCompra = Class
  Private
    FTipoVisao: TTipoVisao;
    FLayout: TLayout;
    FAposCarregarDadosDaLinha: TAposCarregarDadosDaLinha;
    objValidaExcel: TValidadorExcel;
    procedure pReiniciaLinha(var Linha: TLinha);

    Function fProcessaArquivoPrg(cxProgresso: TCxProgressBar): Boolean;

  public
    strCaminhoArquivo: string;

    constructor Create;
    destructor Destroy; override;
    function fSelecionaModelo: boolean;
    procedure pProcessaArquivo();
    procedure pAbrirEditorDeLayout(TipoVisao: TTipoVisao);
    procedure pCarregaCampos();
    procedure pRemoveModelo;
    function fSelecionaArquivo(out blnAcumulaQtd: Boolean): Boolean;
    function fGetNomeModeloSelecionado: String;
    procedure pFazBackup;
    property AposCarregarDadosDaLinha: TAposCarregarDadosDaLinha read FAposCarregarDadosDaLinha write FAposCarregarDadosDaLinha;


  End;

implementation

uses
  Forms,
  untFuncoesSimples, untSelecaoModeloImportacaoPedidoCompra,
  untEditorLayoutPedidoCompra, untSelecionaArquivoPedidoCompra,
  untGravando;

{ TLayout }

constructor TLayout.Create;
begin
  FQrySQL := fCriaQuery;
  FLayouts := TZClient.Create(Nil);
  FCampos  := TCampos.Create;
  FLayouts.qryQuery.SQL.Add('SELECT * FROM LAYPED');
  FLayouts.fAbreClient(True);
end;

destructor TLayout.Destroy;
begin
  FreeAndNil(FLayouts);
  FreeAndNil(FCampos);
  FreeAndNil(FQrySQL);
  inherited;
end;

function TLayout.fGetCamposDataSet: TDataSet;
begin
  Result := FCampos.fGetDataSet;
end;

function TLayout.fGetDataSet: TDataSet;
begin
  Result := FLayouts;
end;

procedure TLayout.pBackup;
begin
  FCampos.pBackup
  {}
end;

procedure TLayout.pNovo();
begin
  FCampos.pNovo;
  FLayouts.Insert;
  FLayouts.FieldByName('LAY_DESCRI').AsString  := '';
  FLayouts.FieldByName('LAY_POSINI').AsInteger := 1;
  FLayouts.FieldByName('LAY_CODITE').AsInteger := 0;
  FLayouts.Post;
end;

procedure TLayout.pRemoveLayout;
begin
  // Se for o layoute padrão do sistema não deixa remover
  If (FLayouts.FieldByName('LAY_PADSIS').AsInteger = 1) Then
  Begin
    pMensagemOk('O Modelo padrão não pode ser removido.');
    Exit;
  End;

  If fPergunta('Remover o layout ' + FLayouts.FieldByName('LAY_CODLAY').AsString + ' - ' + FLayouts.FieldByName('LAY_DESCRI').AsString) then
  Begin
    FLayouts.Delete;
    FLayouts.fSalva;
  End;
end;

procedure TLayout.pSalva;
begin
  fStartTransaction;
  Try
    If FLayouts.FieldByName('AUTOINCREM').AsString = '' Then
    Begin
      FLayouts.Edit;
      FLayouts.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LAYPED', VS_strCodEmp);
      FLayouts.FieldByName('LAY_CODLAY').AsString := fAtualizaProCod('LAYPED', 'LAY_CODLAY');
      FLayouts.Post
    End;
    FLayouts.fSalva;
    FCampos.pSalva(FLayouts.FieldByName('AUTOINCREM').AsString );
    fCommit;
  Except
    on E: Exception do
    Begin
      fRollBack;
      pMensagensErro(e.Message, '[TLayout.pSalva]');
    End;
  End;
end;

procedure TLayout.pSetLayout(strCodLayout: string = '');
begin
  If  strCodLayout <> '' Then
    FCampos.strCodigoLayout := strCodLayout
  Else
    FCampos.strCodigoLayout := FLayouts.FieldByName('LAY_CODLAY').AsString;
end;

procedure TLayout.pSetTipoVisao(Value: TTipoVisao);
begin
  FTipoVisao := Value;
  FCampos.TipoVisao := Value;
end;

{ TCampos }

constructor TCampos.Create;
begin
  FCampos := TZClient.Create(Nil);
  FDataBackup := TUniClientDataSet.Create(nil);
  FQrySQL := fCriaQuery;

  FCampos.BeforePost := OnBeforePost;
end;

destructor TCampos.Destroy;
begin
  FreeAndNil(FCampos);
  FreeAndNil(FQrySQL);
  FreeAndNil(FDataBackup);
  inherited;
end;

function TCampos.fGetDataSet: TDataSet;
begin
  Result := FCampos;
end;

class function TCampos.fIntegerToTipoCampo(value: integer): TTipoCampo;
begin
  case value of
    01: Result := tpCodigoItem;
    02: Result := tpDescricao;
    03: Result := tpUnidade;
    04: Result := tpEmbalagem;
    05: Result := tpQuantidade;
    06: Result := tpVrUnitario;
    07: Result := tpDes01;
    08: Result := tpDes02;
    09: Result := tpDes03;
    10: Result := tpdes04;
    11: Result := tpDes05;
    12: Result := tpDes06;
    13: Result := tpAlqIPI;
    14: Result := tpValIPI;
    15: Result := tpAqlSub;
    16: Result := tpValSub;
    17: Result := tpAlqImpostoImportacao;
    18: Result := tpValImpostoImportacao;
    19: Result := tpAqlIPIImportacao;
    20: Result := tpValIPIImportacao;
    21: Result := tpAlqPIS;
    22: Result := tpValPIS;
    23: Result := tpAqlCOFINS;
    24: Result := tpValCOFINS;
    27: Result := tpAlqCbs;
    28: Result := tpAlqIbs;
    29: Result := tpAlq_Is;
  Else
    Result := tpIndefinido;
  End;
end;

procedure TCampos.OnBeforePost(DataSet: TDataSet);
  function fVerificaSeSoLetras(Value: String): Boolean;
    Var i: Integer;
  Begin
    Result := True;
    For i:= 0 To Length(Value) do
      If Not Value[i].IsLetter Then
        Exit(False)
  End;
var Formula: String;
begin
  If DataSet.FieldByName('LAY_POSLAY').ASString = '' Then
    Exit;

  If Not (Pos('CALC(', Uppercase(DataSet.FieldByName('LAY_POSLAY').AsString))) > 0 Then
  Begin
    FDataBackup.Filtered  := False;
    FDataBackup.Filter := 'LAY_POSLAY = ' + fQuotedStr(DataSet.FieldByName('LAY_POSLAY').ASString);
    FDataBackup.Filtered  := True;
    If (FDataBackup.RecordCount >= 1) And
       ((FDataBackup.FieldByName('LAY_IDENTI').AsInteger) <> (DataSet.FieldByName('LAY_IDENTI').AsInteger)) Then
    Begin
      FCampos.FieldByName('LAY_POSLAY').AsString := '';
      pMensagemOk('Esta coluna já esta sendo utilizada pelo o campo ' + FDataBackup.FieldByName('LAY_DESCAM').AsString);
      Exit;
    End;
    If Not fVerificaSeSoLetras(Uppercase(DataSet.FieldByName('LAY_POSLAY').AsString)) Then
    Begin
      FCampos.FieldByName('LAY_POSLAY').AsString := '';
      pMensagemOk('Apenas letras são permitidas, pois este campo representa a coluna do Excel.' + FDataBackup.FieldByName('LAY_DESCAM').AsString);
      Exit;
    End;

  End
  Else
  If (Pos('CALC(', Uppercase(DataSet.FieldByName('LAY_POSLAY').AsString))) > 0 Then
  Begin
    Formula := DataSet.FieldByName('LAY_POSLAY').AsString;
    If Formula.CountChar('(') <> Formula.CountChar(')') Then
    Begin
      pMensagemOk('Formula inválida');
      FCampos.FieldByName('LAY_POSLAY').AsString := 'CALC()';
      Exit;
    End
    Else If Formula[Length(Formula)] <> ')' Then
    Begin
      pMensagemOk('Todos os campos devem estar dentro da chamada CALC(), exemplo: CALC((A*B) - C)');
      FCampos.FieldByName('LAY_POSLAY').AsString := 'CALC()';
      Exit;
    End;
  End;
end;

procedure TCampos.pBackup;
begin
  If Not(FCampos.State in dsEditModes) Then
    FDataBackup.Data := FCampos.Data;

end;

procedure TCampos.pCriaEstrutura(strCodLay: String = '');
begin
  FCampos.qryQuery.SQL.Clear;
  FCampos.qryQuery.SQL.Add('SELECT LAYPDC.* FROM LAYPDC');
  If strCodLay <> '' Then
  Begin
    FCampos.qryQuery.SQL.Add(' WHERE LAY_SEQLAY = (SELECT AUTOINCREM FROM LAYPED WHERE LAY_CODLAY = :CODLAY)');
    If TipoVisao = tvVisualizacao Then
      FCampos.qryQuery.SQL.Add(' AND IFNULL(LAY_POSLAY, "")<>  ""');
  End
  Else
    FCampos.qryQuery.SQL.Add(' WHERE FALSE');
end;

procedure TCampos.pNovo;
begin
  FCampos.Close;
  pCriaEstrutura();
  FCampos.fAbreClient(True);
  pPreencheCamposNovo;
  FDataBackup.Data := FCampos.Data;
end;

procedure TCampos.pPreencheCamposNovo;
  var i: integer;
  procedure InsertNovo(strCampo, strPosicaoPadrao: string; strIdentificao: integer);
  Begin
    FCampos.FieldByName('LAY_DESCAM').AsString := strCampo;
    FCampos.FieldByName('LAY_IDENTI').AsInteger:= strIdentificao;
    FCampos.FieldByName('LAY_POSPAD').AsString := strPosicaoPadrao;
    FCampos.FieldByName('LAY_POSLAY').AsString := '';
  End;
begin
  for i:= 1 To 24 do
  Begin
    FCampos.Append;
    case i of
      01: InsertNovo('Código do Item/Código de Fábrica', 'A', i);
      02: InsertNovo('Descrição', 'B', i);
      03: InsertNovo('Unidade', 'C', i);
      04: InsertNovo('Embalagem', 'D', i);
      05: InsertNovo('Quantidade', 'E', i);
      06: InsertNovo('Vr. Unitário','F', i);
      07: InsertNovo('% Des. 1', 'G', i);
      08: InsertNovo('% Des. 2', 'H', i);
      09: InsertNovo('% Des. 3', 'I', i);
      10: InsertNovo('% Des. 4', 'J', i);
      11: InsertNovo('% Des. 5', 'K', i);
      12: InsertNovo('% Des. 6', 'L', i);
      13: InsertNovo('% IPI', 'M', i);
      14: InsertNovo('Valor IPI', 'N', i);
      15: InsertNovo('% Sub.', 'O', i);
      16: InsertNovo('Valor Sub', 'P', i);
      17: InsertNovo('% imposto de Importação', 'Q', i);
      18: InsertNovo('Valor Imposto Importação', 'R', i);
      19: InsertNovo('% IPI Importação', 'S', i);
      20: InsertNovo('Valor do IPI Importação', 'T', i);
      21: InsertNovo('% PIS', 'U', i);
      22: InsertNovo('Valor do PIS', 'V', i);
      23: InsertNovo('% COFINS', 'W', i);
      24: InsertNovo('Valor COFINS', 'X', i);
    End;
    FCampos.Post;
  End;

  pIncluiCamposReforma;
end;

// IDs 25 e 26 sao Empresa e Dia util na 150.x: os campos da reforma usam 27 a 29 em todas as versoes.
procedure TCampos.pIncluiCamposReforma;
  procedure pIncluiCampo(const AstrCampo, AstrPosicaoPadrao: String; AintIdentificacao: Integer);
  Begin
    If FCampos.Locate('LAY_IDENTI', AintIdentificacao, []) Then
      Exit;

    FCampos.Append;
    FCampos.FieldByName('LAY_DESCAM').AsString := AstrCampo;
    FCampos.FieldByName('LAY_IDENTI').AsInteger:= AintIdentificacao;
    FCampos.FieldByName('LAY_POSPAD').AsString := AstrPosicaoPadrao;
    FCampos.FieldByName('LAY_POSLAY').AsString := '';
    FCampos.Post;
  End;
begin
  pIncluiCampo('% CBS', 'AA', 27);
  pIncluiCampo('% IBS', 'AB', 28);
  pIncluiCampo('% IS', 'AC', 29);
end;

procedure TCampos.pSalva(strAutoincrem: string);
begin
  FCampos.First;
  While not FCampos.Eof Do
  Begin
    If FCampos.FieldByName('AUTOINCREM').AsString = '' Then
    Begin
      FCampos.Edit;
      FCampos.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LAYPDC', VS_strCodEmp);
      FCampos.FieldByName('LAY_SEQLAY').AsString := strAutoincrem;
      FCampos.Edit;
    End;
    FCampos.Next;
  End;
  FCampos.fSalva;
end;

procedure TCampos.SetCodigoLayout(const Value: string);
begin
  FCodigoLayout := Value;
  FCampos.Close;
  pCriaEstrutura(Value);
  FCampos.QryQuery.ParamByName('CODLAY').AsString := Value;
  FCampos.fAbreClient(True);
  If TipoVisao = tvEdicao Then
    pIncluiCamposReforma;
  FDataBackup.Data := FCampos.Data;

end;

{ TImportaPlanilhaPedidoCompra }

constructor TImportaPlanilhaPedidoCompra.Create;
begin
  FLayout := TLayout.Create;
  pCriarFormularios(TfrmSelecaoModeloImportacaoPedidoCompra, frmSelecaoModeloImportacaoPedidoCompra);
  frmSelecaoModeloImportacaoPedidoCompra.ObjImportaPlanilhaPedidoCompra := Self;
  frmSelecaoModeloImportacaoPedidoCompra.dtsModelos.DataSet := FLayout.fGetDataSet;

  pCriarFormularios(TfrmEditorLayoutPedidoCompra, frmEditorLayoutPedidoCompra);
  frmEditorLayoutPedidoCompra.ObjImportaPlanilhaPedidoCompra := Self;
  frmEditorLayoutPedidoCompra.dtsCampos.DataSet := FLayout.fGetCamposDataSet;

  pCriarFormularios(TfrmSelecionaArquivoPedidoCompra, frmSelecionaArquivoPedidoCompra);
  frmSelecionaArquivoPedidoCompra.ObjImportaPlanilhaPedidoCompra := Self;
end;

destructor TImportaPlanilhaPedidoCompra.Destroy;
begin
  FreeAndNil(FLayout);
  FreeAndNil(frmEditorLayoutPedidoCompra);
  pFreeAndNil(frmSelecaoModeloImportacaoPedidoCompra);
  pFreeAndNil(frmSelecionaArquivoPedidoCompra);
end;

procedure TImportaPlanilhaPedidoCompra.pAbrirEditorDeLayout(
  TipoVisao: TTipoVisao);
begin
  FTipoVisao := TipoVisao;
  FLayout.TipoVisao := FTipoVisao;
  frmEditorLayoutPedidoCompra.TipoVisao := TipoVisao;
  If TipoVisao in([tvEdicao, tvVisualizacao]) Then
  Begin
    If (TipoVisao = tvEdicao) And (FLayout.fGetDataSet.FieldByname('LAY_PADSIS').AsInteger = 1) Then
    Begin
      pMensagemOk('O Modelo padrão não pode ser alterado.');
      Exit;
    End;
    FLayout.pSetLayout(FLayout.fGetDataSet.FieldByname('LAY_CODLAY').AsString);
    frmEditorLayoutPedidoCompra.edtNomLayout.Text := FLayout.fGetDataSet.FieldByname('LAY_DESCRI').AsString;
    frmEditorLayoutPedidoCompra.edtPosIniArquiv.Value := FLayout.fGetDataSet.FieldByname('LAY_POSINI').AsInteger;
  End
  Else
  Begin
    FLayout.pNovo;
    frmEditorLayoutPedidoCompra.edtNomLayout.Text := '';
    frmEditorLayoutPedidoCompra.edtPosIniArquiv.Value := 0;
  End;

  If frmEditorLayoutPedidoCompra.Showmodal = mrOk Then
  Begin
    If TipoVisao = tvVisualizacao Then
      Exit;
    FLayout.fGetDataSet.Edit;
    FLayout.fGetDataSet.FieldByName('LAY_DESCRI').AsString := frmEditorLayoutPedidoCompra.edtNomLayout.Text;
    FLayout.fGetDataSet.FieldByName('LAY_POSINI').AsInteger:= frmEditorLayoutPedidoCompra.edtPosIniArquiv.Value;
    FLayout.pSalva;
  End
  Else If TipoVisao = tvInsercao Then
    FLayout.fGetDataSet.Delete
end;

procedure TImportaPlanilhaPedidoCompra.pCarregaCampos();
begin
  FLayout.pSetLayout;
end;

procedure TImportaPlanilhaPedidoCompra.pFazBackup;
begin
  FLayout.pBackup;
end;

function TImportaPlanilhaPedidoCompra.fGetNomeModeloSelecionado: String;
begin
  Result := FLayout.fGetDataSet.FieldByName('LAY_DESCRI').AsString;
end;

function TImportaPlanilhaPedidoCompra.fSelecionaArquivo(out blnAcumulaQtd: Boolean): Boolean;
begin
  frmSelecionaArquivoPedidoCompra.lblModelo.Caption := FLayout.fGetDataSet.FieldByName('LAY_DESCRI').AsString;
  Result := (frmSelecionaArquivoPedidoCompra.Showmodal = mrOk);
  If Result Then
  Begin
    strCaminhoArquivo := frmSelecionaArquivoPedidoCompra.edtArquivo.Text;
    blnAcumulaQtd := (frmSelecionaArquivoPedidoCompra.rgpQuantidade.ItemIndex = 0);
    FLayout.pSetLayout;
  End;
end;

procedure TImportaPlanilhaPedidoCompra.pRemoveModelo;
begin
  FLayout.pRemoveLayout;
end;

function TImportaPlanilhaPedidoCompra.fSelecionaModelo: boolean;
begin
  result := (frmSelecaoModeloImportacaoPedidoCompra.ShowModal = mrOk);
end;

procedure TImportaPlanilhaPedidoCompra.pReiniciaLinha(var Linha: TLinha);
begin
  Linha.strCodigoItem := '';
  Linha.strDescricao := '';
  Linha.strUnidade := '';
  Linha.fltEmbalagem := 0;
  Linha.fltQuantidade := 0;
  Linha.fltVrUnitario := 0;
  Linha.fltDes01 := 0;
  Linha.fltDes02 := 0;
  Linha.fltDes03 := 0;
  Linha.fltdes04 := 0;
  Linha.fltDes05 := 0;
  Linha.fltDes06 := 0;
  Linha.flAlqIPI := 0;
  Linha.fltValIPI := 0;
  Linha.fltAqlSub := 0;
  Linha.fltValSub := 0;
  Linha.fltAlqImpostoImportacao := 0;
  Linha.fltValImpostoImportacao := 0;
  Linha.fltAqlIPIImportacao := 0;
  Linha.fltValIPIImportacao := 0;
  Linha.fltAlqPIS := 0;
  Linha.fltValPIS := 0;
  Linha.fltAqlCOFINS := 0;
  Linha.fltValCOFINS := 0;
  Linha.fltAlqCbs := 0;
  Linha.fltAlqIbs := 0;
  Linha.fltAlq_Is := 0;
end;

procedure TImportaPlanilhaPedidoCompra.pProcessaArquivo();
  Var
    frmGravando: TfrmGravando;
Begin
  TfrmGravando.fExecuta(fProcessaArquivoPrg, frmGravando, 'Importando produtos, aguarde...');
End;

Function TImportaPlanilhaPedidoCompra.fProcessaArquivoPrg(cxProgresso: TCxProgressBar): Boolean;
var blnPararProcesso: Boolean;
    Linha: TLinha;
    intLinha: integer;
    strColuna: string;
    CamposLayout: TCamposLayoutUsados;
    blnUtilizado: boolean;
    function fConvertVazioToFloat(value: string): Double;
    Begin
      value := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(value, '%', ''), 'R$', ''), '.', '');
      If value = '' Then
        Result := 0
      Else
        Result := StrToFloatDef(value, 0);
    End;
begin
  Result := True;
  CamposLayout := Default(TCamposLayoutUsados);

  If strCaminhoArquivo = '' Then
    pMensagemOk('Arquivo não foi informado');

  objValidaExcel := TValidadorExcel.Create(strCaminhoArquivo, FLayout.FLayouts.RecordCount-1, '', '', FLayout.fGetDataSet.FieldByName('LAY_POSINI').AsInteger);
  Try
    blnPararProcesso := False;
    FLayout.fGetCamposDataSet.First;
    While Not FLayout.fGetCamposDataSet.Eof Do
    Begin
      blnUtilizado := (Not fEmptyStr(FLayout.fGetCamposDataSet.FieldByName('LAY_POSLAY').AsString));
      case  TCampos.fIntegerToTipoCampo(FLayout.fGetCamposDataSet.FieldByName('LAY_IDENTI').AsInteger) of
        tpCodigoItem          : CamposLayout.blnCodigoItem := blnUtilizado;
        tpDescricao           : CamposLayout.blnDescricao := blnUtilizado;
        tpUnidade             : CamposLayout.blnUnidade := blnUtilizado;
        tpEmbalagem           : CamposLayout.blnEmbalagem := blnUtilizado;
        tpQuantidade          : CamposLayout.blnQuantidade := blnUtilizado;
        tpVrUnitario          : CamposLayout.blnVrUnitario := blnUtilizado;
        tpDes01               : CamposLayout.blnDes01:= blnUtilizado;
        tpDes02               : CamposLayout.blnDes02:= blnUtilizado;
        tpDes03               : CamposLayout.blnDes03:= blnUtilizado;
        tpdes04               : CamposLayout.blndes04:= blnUtilizado;
        tpDes05               : CamposLayout.blnDes05:= blnUtilizado;
        tpDes06               : CamposLayout.blnDes06:= blnUtilizado;
        tpAlqIPI              : CamposLayout.blnAlqIPI:= blnUtilizado;
        tpValIPI              : CamposLayout.blnValIPI:= blnUtilizado;
        tpAqlSub              : CamposLayout.blnAqlSub:= blnUtilizado;
        tpValSub              : CamposLayout.blnValSub:= blnUtilizado;
        tpAlqImpostoImportacao: CamposLayout.blnAlqImpostoImportacao:= blnUtilizado;
        tpValImpostoImportacao: CamposLayout.blnValImpostoImportacao:= blnUtilizado;
        tpAqlIPIImportacao    : CamposLayout.blnAqlIPIImportacao:= blnUtilizado;
        tpValIPIImportacao    : CamposLayout.blnValIPIImportacao:= blnUtilizado;
        tpAlqPIS              : CamposLayout.blnAlqPIS:= blnUtilizado;
        tpValPIS              : CamposLayout.blnValPIS:= blnUtilizado;
        tpAqlCOFINS           : CamposLayout.blnAqlCOFINS := blnUtilizado;
        tpValCOFINS           : CamposLayout.blnValCOFINS := blnUtilizado;
        tpAlqCbs              : CamposLayout.blnAlqCbs := blnUtilizado;
        tpAlqIbs              : CamposLayout.blnAlqIbs := blnUtilizado;
        tpAlq_Is              : CamposLayout.blnAlq_Is := blnUtilizado;
      End;
      FLayout.fGetCamposDataSet.Next;
    End;


    cxProgresso.Properties.Max := objValidaExcel.ArquivoCSV.Count;

    For intLinha := 0 To (objValidaExcel.ArquivoCSV.Count -1) Do
    Begin
      FLayout.fGetCamposDataSet.First;
      pReiniciaLinha(Linha);
      While Not FLayout.fGetCamposDataSet.Eof Do
      Begin
        If Not fEmptyStr(FLayout.fGetCamposDataSet.FieldByName('LAY_POSLAY').AsString) Then
        Begin
          strColuna := FLayout.fGetCamposDataSet.FieldByName('LAY_POSLAY').AsString;
          case  TCampos.fIntegerToTipoCampo(FLayout.fGetCamposDataSet.FieldByName('LAY_IDENTI').AsInteger) of
            tpCodigoItem          : Linha.strCodigoItem := (objValidaExcel.fGetValueCSV(intLinha, strColuna));
            tpDescricao           : Linha.strDescricao  := (objValidaExcel.fGetValueCSV(intLinha, strColuna));
            tpUnidade             : Linha.strUnidade    := (objValidaExcel.fGetValueCSV(intLinha, strColuna));
            tpEmbalagem           : Linha.fltEmbalagem  := fConvertVazioToFloat(objValidaExcel.fGetValueCSV(intLinha, strColuna));
            tpQuantidade          : Linha.fltQuantidade := fConvertVazioToFloat(objValidaExcel.fGetValueCSV(intLinha, strColuna));
            tpVrUnitario          : Linha.fltVrUnitario := fConvertVazioToFloat(objValidaExcel.fGetValueCSV(intLinha, strColuna));
            tpDes01               : Linha.fltDes01      := Round(fConvertVazioToFloat(objValidaExcel.fGetValueCSV(intLinha, strColuna)));
            tpDes02               : Linha.fltDes02      := fConvertVazioToFloat(objValidaExcel.fGetValueCSV(intLinha, strColuna));
            tpDes03               : Linha.fltDes03      := fConvertVazioToFloat(objValidaExcel.fGetValueCSV(intLinha, strColuna));
            tpdes04               : Linha.fltdes04      := fConvertVazioToFloat(objValidaExcel.fGetValueCSV(intLinha, strColuna));
            tpDes05               : Linha.fltDes05      := fConvertVazioToFloat(objValidaExcel.fGetValueCSV(intLinha, strColuna));
            tpDes06               : Linha.fltDes06      := fConvertVazioToFloat(objValidaExcel.fGetValueCSV(intLinha, strColuna));
            tpAlqIPI              : Linha.flAlqIPI      := fConvertVazioToFloat(objValidaExcel.fGetValueCSV(intLinha, strColuna));
            tpValIPI              : Linha.fltValIPI     := fConvertVazioToFloat(objValidaExcel.fGetValueCSV(intLinha, strColuna));
            tpAqlSub              : Linha.fltAqlSub     := fConvertVazioToFloat(objValidaExcel.fGetValueCSV(intLinha, strColuna));
            tpValSub              : Linha.fltValSub     := fConvertVazioToFloat(objValidaExcel.fGetValueCSV(intLinha, strColuna));
            tpAlqImpostoImportacao: Linha.fltAlqImpostoImportacao := fConvertVazioToFloat(objValidaExcel.fGetValueCSV(intLinha, strColuna));
            tpValImpostoImportacao: Linha.fltValImpostoImportacao := fConvertVazioToFloat(objValidaExcel.fGetValueCSV(intLinha, strColuna));
            tpAqlIPIImportacao    : Linha.fltAqlIPIImportacao := fConvertVazioToFloat(objValidaExcel.fGetValueCSV(intLinha, strColuna));
            tpValIPIImportacao    : Linha.fltValIPIImportacao := fConvertVazioToFloat(objValidaExcel.fGetValueCSV(intLinha, strColuna));
            tpAlqPIS              : Linha.fltAlqPIS     := fConvertVazioToFloat(objValidaExcel.fGetValueCSV(intLinha, strColuna));
            tpValPIS              : Linha.fltValPIS     := fConvertVazioToFloat(objValidaExcel.fGetValueCSV(intLinha, strColuna));
            tpAqlCOFINS           : Linha.fltAqlCOFINS  := fConvertVazioToFloat(objValidaExcel.fGetValueCSV(intLinha, strColuna));
            tpValCOFINS           : Linha.fltValCOFINS  := fConvertVazioToFloat(objValidaExcel.fGetValueCSV(intLinha, strColuna));
            tpAlqCbs              : Linha.fltAlqCbs     := fConvertVazioToFloat(objValidaExcel.fGetValueCSV(intLinha, strColuna));
            tpAlqIbs              : Linha.fltAlqIbs     := fConvertVazioToFloat(objValidaExcel.fGetValueCSV(intLinha, strColuna));
            tpAlq_Is              : Linha.fltAlq_Is     := fConvertVazioToFloat(objValidaExcel.fGetValueCSV(intLinha, strColuna));
          End;
        End;
        FLayout.fGetCamposDataSet.Next;
        If FLayout.fGetCamposDataSet.Eof Then
          If Assigned(FAposCarregarDadosDaLinha) Then
          Begin
            blnPararProcesso := False;
            FAposCarregarDadosDaLinha(Linha, CamposLayout, blnPararProcesso);
          End;
      End;
      If blnPararProcesso Then
        Break;

      cxProgresso.Position := cxProgresso.Position + 1;
      Application.ProcessMessages;
    End;
  Finally
    FreeAndNil(objValidaExcel);
  End;

end;


end.
