unit ImportacaoDados.Controller.ImportarItemFatVenda;

interface

uses
  Classes, SysUtils, untTValidaExcel, cxProgressBar, System.Generics.Collections, DB, Uni, Variants,
  ImportacaoDados.Interfaces,  ImportacaoDados.Controller.ItemFatVenda,
  ImportacaoDados.Model.ImportacaoArquivo, untTypesSistema;

Type

  TValidacaoDadosImportacaoItemFatVenda = class;

  TImportaPlanilhaItemFatVenda = class(TImportaPlanilha)
  private
  public
    constructor Create(Const aModelo: IModeloArquivoImportacao; const ACancelouOperacao : TReferenceBooleanFunction); override;
    destructor Destroy; override;
    function fInserirCadastros: Boolean; override;
  End;

  TValidacaoDadosImportacaoItemFatVenda =  Class(TValidacaoDadosImportacao)
  private
    FItemFatVenda:  TItemFatVendaController;

    FIndiceCodItem,
    FIndiceQtdeItem,
    FIndiceDestinoItem,
    FIndiceVlrUnitItem,
    FIndiceVlrComDescon,
    FIndiceDescontoItem,
    FIndiceTabPreCad,
    FIndiceComplItem,
    FIndiceUnidadeItem,
    FIndiceEmpFat,
    FIndiceLoteArm,
    FIndiceLocRet,
    FIndiceTpEntrega,
    FIndiceMotivo,
    FIndiceCliRetira,
    FIndiceDiasEntrega,
    FIndiceDtaEntrega,
    FIndicePegou,
    FIndiceBrinde: Integer;

    procedure pSetarDados(Const aLinha: ILinha);
    procedure pSetarLinhaPadraoModelo;
    procedure pAdicionaInconsistencia(Const aLinha: ILinha; Const Coluna, Campo, Mensagem: String);
    procedure pAnalisaInconsistenciaProduto(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaUnidade(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaEmpresa(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaLoteArm(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaDataEntrega(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaTabelaPreco(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaLocalRetira(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaDestino(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaTipoEntrega(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaMotivo(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaCliRetira(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaCliPegou(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaBrinde(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaCamposNumericos(Const aLinha: ILinha);
    procedure pAnalisaInconsistenciaMultiploDeVenda(Const aLinha: ILinha);
  public
    constructor Create(aArquivoImportacao: IImportaPlanilha); override;
    destructor  Destroy; override;
    function fValidarLinha(Const aLinha: ILinha): Boolean; override;
    procedure pAtualizarParametrosValidacao; override;
  End;

implementation

uses
  untFuncoesSimples, untCadCid, untFuncoesGenerica, StrUtils;

{ TImportaPlanilhaItemFatVenda }

constructor TImportaPlanilhaItemFatVenda.Create(Const aModelo: IModeloArquivoImportacao; const ACancelouOperacao : TReferenceBooleanFunction);
begin
  inherited;

  Valida := TValidacaoDadosImportacaoItemFatVenda.Create(Self);

end;

destructor TImportaPlanilhaItemFatVenda.Destroy;
begin

  inherited;
end;

function TImportaPlanilhaItemFatVenda.fInserirCadastros: Boolean;
begin
  Result := True;
end;


{ TValidacaoDadosImportacaoItemFatVenda }

constructor TValidacaoDadosImportacaoItemFatVenda.Create(aArquivoImportacao: IImportaPlanilha);
begin
  inherited;
  FItemFatVenda := TItemFatVendaController.Create;
end;

destructor TValidacaoDadosImportacaoItemFatVenda.Destroy;
begin
  FreeAndNil(FItemFatVenda);
end;

procedure TValidacaoDadosImportacaoItemFatVenda.pAnalisaInconsistenciaProduto(Const aLinha: ILinha);
var
  recCampoLinhaAux: TCampoPlanilha;
Begin
  If fEmptyStr(FItemFatVenda.ItemFatVenda.CodItem) Then
    Exit;

  If Not FItemFatVenda.Validacao.fValidarProduto then
  Begin
    pAdicionaInconsistencia(aLinha, aLinha.Campos[FIndiceCodItem].Propriedades.Coluna, aLinha.Campos[FIndiceCodItem].Propriedades.DescricaoCampo, cstValidacaoProduto);
  End
  Else
  Begin
    If fEmptyStr(aLinha.Campos[FIndiceCodItem].Propriedades.Conteudo) Then
    Begin
      recCampoLinhaAux          := aLinha.Campos[FIndiceCodItem].Propriedades;
      recCampoLinhaAux.Conteudo :=  FItemFatVenda.ItemFatVenda.CodItem;
      aLinha.Campos[FIndiceCodItem].Propriedades := recCampoLinhaAux;
    End;
  End;
End;

procedure TValidacaoDadosImportacaoItemFatVenda.pAnalisaInconsistenciaUnidade(Const aLinha: ILinha);
var
  recCampoLinhaAux: TCampoPlanilha;
Begin
  If fEmptyStr(FItemFatVenda.ItemFatVenda.UnidadeItem) Then
    Exit;

  If Not FItemFatVenda.Validacao.fValidarUnidade then
  Begin
    pAdicionaInconsistencia(aLinha, aLinha.Campos[FIndiceUnidadeItem].Propriedades.Coluna, aLinha.Campos[FIndiceUnidadeItem].Propriedades.DescricaoCampo, cstValidacaoUnidade);
  End
  Else
  Begin
    If fEmptyStr(aLinha.Campos[FIndiceUnidadeItem].Propriedades.Conteudo) Then
    Begin
      recCampoLinhaAux          := aLinha.Campos[FIndiceUnidadeItem].Propriedades;
      recCampoLinhaAux.Conteudo :=  FItemFatVenda.ItemFatVenda.UnidadeItem;
      aLinha.Campos[FIndiceUnidadeItem].Propriedades := recCampoLinhaAux;
    End;
  End;
End;

procedure TValidacaoDadosImportacaoItemFatVenda.pAnalisaInconsistenciaEmpresa(Const aLinha: ILinha);
var
  recCampoLinhaAux: TCampoPlanilha;
Begin
  If fEmptyStr(FItemFatVenda.ItemFatVenda.EmpFat) Then
    Exit;

  If Not FItemFatVenda.Validacao.fValidarEmpresa then
  Begin
    pAdicionaInconsistencia(aLinha, aLinha.Campos[FIndiceEmpFat].Propriedades.Coluna, aLinha.Campos[FIndiceEmpFat].Propriedades.DescricaoCampo, cstValidacaoEmpresa);
  End
  Else
  Begin
    If fEmptyStr(aLinha.Campos[FIndiceEmpFat].Propriedades.Conteudo) Then
    Begin
      recCampoLinhaAux := aLinha.Campos[FIndiceEmpFat].Propriedades;
      recCampoLinhaAux.Conteudo :=  FItemFatVenda.ItemFatVenda.EmpFat;
      aLinha.Campos[FIndiceEmpFat].Propriedades := recCampoLinhaAux;
    End;
  End;
End;

procedure TValidacaoDadosImportacaoItemFatVenda.pAnalisaInconsistenciaLoteArm(Const aLinha: ILinha);
var
  recCampoLinhaAux: TCampoPlanilha;
Begin
  If fEmptyStr(FItemFatVenda.ItemFatVenda.LoteArm) Then
    Exit;

  If Not FItemFatVenda.Validacao.fValidarLoteArm then
  Begin
    If (fCfgSis('CTLEST') = 1) Then
      pAdicionaInconsistencia(aLinha, aLinha.Campos[FIndiceLoteArm].Propriedades.Coluna, aLinha.Campos[FIndiceLoteArm].Propriedades.DescricaoCampo, cstValidacaoLote)
    Else
      pAdicionaInconsistencia(aLinha, aLinha.Campos[FIndiceLoteArm].Propriedades.Coluna, aLinha.Campos[FIndiceLoteArm].Propriedades.DescricaoCampo, cstValidacaoArm);
  End
  Else
  Begin
    If fEmptyStr(aLinha.Campos[FIndiceLoteArm].Propriedades.Conteudo) Then
    Begin
      recCampoLinhaAux := aLinha.Campos[FIndiceLoteArm].Propriedades;
      recCampoLinhaAux.Conteudo :=  FItemFatVenda.ItemFatVenda.LoteArm;
      aLinha.Campos[FIndiceLoteArm].Propriedades := recCampoLinhaAux;
    End;
  End;
End;

procedure TValidacaoDadosImportacaoItemFatVenda.pAnalisaInconsistenciaDataEntrega(Const aLinha: ILinha);
Begin
  If Not FItemFatVenda.Validacao.fValidarDataEntrega Then
  Begin
    pAdicionaInconsistencia(aLinha,
                            aLinha.Campos[FIndiceDtaEntrega].Propriedades.Coluna,
                            aLinha.Campos[FIndiceDtaEntrega].Propriedades.DescricaoCampo,
                            cstValidacaoDataEntrega);
  End;
End;


procedure TValidacaoDadosImportacaoItemFatVenda.pAnalisaInconsistenciaTabelaPreco(Const aLinha: ILinha);
var
  recCampoLinhaAux: TCampoPlanilha;
Begin
  If fEmptyStr(FItemFatVenda.ItemFatVenda.TabPreCad) Then
    Exit;

  If Not FItemFatVenda.Validacao.fValidarTabelaPreco then
  Begin
    pAdicionaInconsistencia(aLinha, aLinha.Campos[FIndiceTabPreCad].Propriedades.Coluna, aLinha.Campos[FIndiceTabPreCad].Propriedades.DescricaoCampo, cstValidacaoTabelaPreco);
  End
  Else
  Begin
    If fEmptyStr(aLinha.Campos[FIndiceTabPreCad].Propriedades.Conteudo) Then
    Begin
      recCampoLinhaAux := aLinha.Campos[FIndiceTabPreCad].Propriedades;
      recCampoLinhaAux.Conteudo :=  FItemFatVenda.ItemFatVenda.TabPreCad;
      aLinha.Campos[FIndiceTabPreCad].Propriedades := recCampoLinhaAux;
    End;
  End;
End;


procedure TValidacaoDadosImportacaoItemFatVenda.pAnalisaInconsistenciaLocalRetira(Const aLinha: ILinha);
var
  recCampoLinhaAux: TCampoPlanilha;
Begin
  If fEmptyStr(FItemFatVenda.ItemFatVenda.LocRet) Then
    Exit;

  If Not (StrUtils.MatchStr(FItemFatVenda.ItemFatVenda.LocRet,['C', 'E']))  Then
  Begin
    pAdicionaInconsistencia(aLinha,
                            aLinha.Campos[FIndiceLocRet].Propriedades.Coluna,
                            aLinha.Campos[FIndiceLocRet].Propriedades.DescricaoCampo,
                            cstValidacaoLocalRetira);
  End
  Else
  Begin
    recCampoLinhaAux := aLinha.Campos[FIndiceLocRet].Propriedades;
    recCampoLinhaAux.Conteudo := FItemFatVenda.ItemFatVenda.LocRet;
    aLinha.Campos[FIndiceLocRet].Propriedades := recCampoLinhaAux;
  End;
End;

procedure TValidacaoDadosImportacaoItemFatVenda.pAnalisaInconsistenciaDestino(Const aLinha: ILinha);
var
  recCampoLinhaAux: TCampoPlanilha;
Begin
  If fEmptyStr(FItemFatVenda.ItemFatVenda.DestinoItem) Then
    Exit;

  If Not (StrUtils.MatchStr(FItemFatVenda.ItemFatVenda.DestinoItem,['R', 'E']))  Then
  Begin
    pAdicionaInconsistencia(aLinha,
                            aLinha.Campos[FIndiceDestinoItem].Propriedades.Coluna,
                            aLinha.Campos[FIndiceDestinoItem].Propriedades.DescricaoCampo,
                            cstValidacaoDestino);
  End
  Else
  Begin
    recCampoLinhaAux := aLinha.Campos[FIndiceDestinoItem].Propriedades;
    recCampoLinhaAux.Conteudo := FItemFatVenda.ItemFatVenda.DestinoItem;
    aLinha.Campos[FIndiceDestinoItem].Propriedades := recCampoLinhaAux;
  End;
End;

procedure TValidacaoDadosImportacaoItemFatVenda.pAnalisaInconsistenciaTipoEntrega(Const aLinha: ILinha);
var
  recCampoLinhaAux: TCampoPlanilha;
Begin
  If fEmptyStr(FItemFatVenda.ItemFatVenda.TpEntrega) Then
    Exit;

  If Not (StrUtils.MatchStr(FItemFatVenda.ItemFatVenda.TpEntrega,['F', 'I']))  Then
  Begin
    pAdicionaInconsistencia(aLinha,
                            aLinha.Campos[FIndiceTpEntrega].Propriedades.Coluna,
                            aLinha.Campos[FIndiceTpEntrega].Propriedades.DescricaoCampo,
                            cstValidacaoTipoEntrega);
  End
  Else
  Begin
    recCampoLinhaAux := aLinha.Campos[FIndiceTpEntrega].Propriedades;
    recCampoLinhaAux.Conteudo := FItemFatVenda.ItemFatVenda.TpEntrega;
    aLinha.Campos[FIndiceTpEntrega].Propriedades := recCampoLinhaAux;
  End;
End;

procedure TValidacaoDadosImportacaoItemFatVenda.pAnalisaInconsistenciaMotivo(Const aLinha: ILinha);
var
  recCampoLinhaAux: TCampoPlanilha;
Begin
  If fEmptyStr(FItemFatVenda.ItemFatVenda.Motivo) Then
    Exit;

  If Not (StrUtils.MatchStr(FItemFatVenda.ItemFatVenda.Motivo,['F', 'A', 'P']))  Then
  Begin
    pAdicionaInconsistencia(aLinha,
                            aLinha.Campos[FIndiceMotivo].Propriedades.Coluna,
                            aLinha.Campos[FIndiceMotivo].Propriedades.DescricaoCampo,
                            cstValidacaoMotivo);
  End
  Else
  Begin
    recCampoLinhaAux := aLinha.Campos[FIndiceMotivo].Propriedades;
    recCampoLinhaAux.Conteudo := FItemFatVenda.ItemFatVenda.Motivo;
    aLinha.Campos[FIndiceMotivo].Propriedades := recCampoLinhaAux;
  End;
End;

procedure TValidacaoDadosImportacaoItemFatVenda.pAnalisaInconsistenciaCliRetira(Const aLinha: ILinha);
var
  recCampoLinhaAux: TCampoPlanilha;
Begin
  If fEmptyStr(FItemFatVenda.ItemFatVenda.CliRetira) Then
    Exit;

  If Not (StrUtils.MatchStr(FItemFatVenda.ItemFatVenda.CliRetira,['S', 'N']))  Then
  Begin
    pAdicionaInconsistencia(aLinha,
                            aLinha.Campos[FIndiceCliRetira].Propriedades.Coluna,
                            aLinha.Campos[FIndiceCliRetira].Propriedades.DescricaoCampo,
                            cstValidacaoClienteRetira);
  End
  Else
  Begin
    recCampoLinhaAux := aLinha.Campos[FIndiceCliRetira].Propriedades;
    recCampoLinhaAux.Conteudo := FItemFatVenda.ItemFatVenda.CliRetira;
    aLinha.Campos[FIndiceCliRetira].Propriedades := recCampoLinhaAux;
  End;
End;

procedure TValidacaoDadosImportacaoItemFatVenda.pAnalisaInconsistenciaCliPegou(Const aLinha: ILinha);
var
  recCampoLinhaAux: TCampoPlanilha;
Begin
  If fEmptyStr(FItemFatVenda.ItemFatVenda.Pegou) Then
    Exit;

  If Not (StrUtils.MatchStr(FItemFatVenda.ItemFatVenda.Pegou,['S', 'N']))  Then
  Begin
    pAdicionaInconsistencia(aLinha,
                            aLinha.Campos[FIndicePegou].Propriedades.Coluna,
                            aLinha.Campos[FIndicePegou].Propriedades.DescricaoCampo,
                            cstValidacaoPegou);
  End
  Else
  Begin
    recCampoLinhaAux := aLinha.Campos[FIndicePegou].Propriedades;
    recCampoLinhaAux.Conteudo := FItemFatVenda.ItemFatVenda.Pegou;
    aLinha.Campos[FIndicePegou].Propriedades := recCampoLinhaAux;
  End;
End;

procedure TValidacaoDadosImportacaoItemFatVenda.pAnalisaInconsistenciaBrinde(Const aLinha: ILinha);
var
  recCampoLinhaAux: TCampoPlanilha;
Begin
  If fEmptyStr(FItemFatVenda.ItemFatVenda.Brinde) Then
    Exit;

  If Not (StrUtils.MatchStr(FItemFatVenda.ItemFatVenda.Brinde,['S', 'N']))  Then
  Begin
    pAdicionaInconsistencia(aLinha,
                            aLinha.Campos[FIndiceBrinde].Propriedades.Coluna,
                            aLinha.Campos[FIndiceBrinde].Propriedades.DescricaoCampo,
                            cstValidacaoBrinde);
  End
  Else
  Begin
    recCampoLinhaAux := aLinha.Campos[FIndiceBrinde].Propriedades;
    recCampoLinhaAux.Conteudo := FItemFatVenda.ItemFatVenda.Brinde;
    aLinha.Campos[FIndiceBrinde].Propriedades := recCampoLinhaAux;
  End;
End;


procedure TValidacaoDadosImportacaoItemFatVenda.pAnalisaInconsistenciaCamposNumericos(Const aLinha: ILinha);
var
  recCampoLinhaAux: TCampoPlanilha;
Begin
  If (FItemFatVenda.ItemFatVenda.QtdeItem     <= 0) And
     (FItemFatVenda.ItemFatVenda.VlrUnitItem  <= 0) And
     (FItemFatVenda.ItemFatVenda.VlrComDescon <= 0) And
     (FItemFatVenda.ItemFatVenda.DescontoItem <= 0) And
     (FItemFatVenda.ItemFatVenda.DiasEntrega  <= 0) Then
    Exit;

  If (FItemFatVenda.ItemFatVenda.QtdeItem > 0) Then
  Begin
    Try
      recCampoLinhaAux := aLinha.Campos[FIndiceQtdeItem].Propriedades;
      recCampoLinhaAux.Conteudo := FloatToStrF(FItemFatVenda.ItemFatVenda.QtdeItem, ffNumber, 12, fCfgSis('DECQTD'));
      aLinha.Campos[FIndiceQtdeItem].Propriedades := recCampoLinhaAux;
    Except
      pAdicionaInconsistencia(aLinha,
                              aLinha.Campos[FIndiceQtdeItem].Propriedades.Coluna,
                              aLinha.Campos[FIndiceQtdeItem].Propriedades.DescricaoCampo,
                              cstValidacaoNumerico);
    End;
  End
  Else
    pAdicionaInconsistencia(aLinha,
                            aLinha.Campos[FIndiceQtdeItem].Propriedades.Coluna,
                            aLinha.Campos[FIndiceQtdeItem].Propriedades.DescricaoCampo,
                            cstValidacaoQuantidadeZerada);



  If (FItemFatVenda.ItemFatVenda.VlrUnitItem > 0) Then
  Begin
    Try
      recCampoLinhaAux := aLinha.Campos[FIndiceVlrUnitItem].Propriedades;
      recCampoLinhaAux.Conteudo := FloatToStrF(FItemFatVenda.ItemFatVenda.VlrUnitItem, ffNumber, 15, fCfgSis('DECUNI'));
      aLinha.Campos[FIndiceVlrUnitItem].Propriedades := recCampoLinhaAux;
    Except
      pAdicionaInconsistencia(aLinha,
                              aLinha.Campos[FIndiceVlrUnitItem].Propriedades.Coluna,
                              aLinha.Campos[FIndiceVlrUnitItem].Propriedades.DescricaoCampo,
                              cstValidacaoNumerico);
    End;
  End
  Else
  Begin
    If (FItemFatVenda.ItemFatVenda.VlrComDescon > 0) Then
    Begin
      Try
        recCampoLinhaAux := aLinha.Campos[FIndiceVlrComDescon].Propriedades;
        recCampoLinhaAux.Conteudo := FloatToStrF(FItemFatVenda.ItemFatVenda.VlrComDescon, ffNumber, 15, fCfgSis('DECUNI'));
        aLinha.Campos[FIndiceVlrComDescon].Propriedades := recCampoLinhaAux;
      Except
        pAdicionaInconsistencia(aLinha,
                                aLinha.Campos[FIndiceVlrComDescon].Propriedades.Coluna,
                                aLinha.Campos[FIndiceVlrComDescon].Propriedades.DescricaoCampo,
                                cstValidacaoNumerico);
      End;
    End;
  End;

  If (FItemFatVenda.ItemFatVenda.DescontoItem > 0 ) Then
  Begin
    Try
      recCampoLinhaAux := aLinha.Campos[FIndiceDescontoItem].Propriedades;
      recCampoLinhaAux.Conteudo := FloatToStrF(FItemFatVenda.ItemFatVenda.DescontoItem, ffNumber, 12, fCfgSis('DECDES'));
      aLinha.Campos[FIndiceDescontoItem].Propriedades := recCampoLinhaAux;
    Except
      pAdicionaInconsistencia(aLinha,
                              aLinha.Campos[FIndiceDescontoItem].Propriedades.Coluna,
                              aLinha.Campos[FIndiceDescontoItem].Propriedades.DescricaoCampo,
                              cstValidacaoNumerico);
    End;
  End;

  If (FItemFatVenda.ItemFatVenda.DiasEntrega > 0) Then
  Begin
    Try
      recCampoLinhaAux := aLinha.Campos[FIndiceDiasEntrega].Propriedades;
      recCampoLinhaAux.Conteudo := IntToStr(FItemFatVenda.ItemFatVenda.DiasEntrega);
      aLinha.Campos[FIndiceDiasEntrega].Propriedades := recCampoLinhaAux;
    Except
      pAdicionaInconsistencia(aLinha,
                              aLinha.Campos[FIndiceDiasEntrega].Propriedades.Coluna,
                              aLinha.Campos[FIndiceDiasEntrega].Propriedades.DescricaoCampo,
                              cstValidacaoNumerico);
    End;
  End;
End;


function TValidacaoDadosImportacaoItemFatVenda.fValidarLinha(Const aLinha: ILinha): Boolean;
begin

  Result := True;

  Try
    pSetarDados(aLinha);

    pAnalisaInconsistenciaProduto(aLinha);
    pAnalisaInconsistenciaUnidade(aLinha);
    pAnalisaInconsistenciaEmpresa(aLinha);
    pAnalisaInconsistenciaLoteArm(aLinha);
    pAnalisaInconsistenciaDataEntrega(aLinha);
    pAnalisaInconsistenciaTabelaPreco(aLinha);
    pAnalisaInconsistenciaLocalRetira(aLinha);
    pAnalisaInconsistenciaDestino(aLinha);
    pAnalisaInconsistenciaTipoEntrega(aLinha);
    pAnalisaInconsistenciaMotivo(aLinha);
    pAnalisaInconsistenciaCliRetira(aLinha);
    pAnalisaInconsistenciaCliPegou(aLinha);
    pAnalisaInconsistenciaBrinde(aLinha);
    pAnalisaInconsistenciaCamposNumericos(aLinha);
    pAnalisaInconsistenciaMultiploDeVenda(aLinha);

    inherited;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[TValidacaoDadosImportacaoItemFatVenda.fValidarLinha]');
    End;
  End;

end;

procedure TValidacaoDadosImportacaoItemFatVenda.pAdicionaInconsistencia(Const aLinha: ILinha; Const Coluna, Campo, Mensagem: String);
var
  recInconsistencia : TRegInconsistencia;
Begin
  recInconsistencia.NumeroLinha := aLinha.NumeroLinha;
  recInconsistencia.Coluna := Coluna;
  recInconsistencia.Campo := Campo;
  recInconsistencia.Descricao := Mensagem;
  FInconsistencias.Inconsistencias.Add(recInconsistencia);
End;

procedure TValidacaoDadosImportacaoItemFatVenda.pAtualizarParametrosValidacao;
begin
  pSetarLinhaPadraoModelo;
end;

procedure TValidacaoDadosImportacaoItemFatVenda.pSetarLinhaPadraoModelo;
var
  recLinha: ILinha;
  intCnt: Integer;
  recCampo: ICampoLinha;
  recPropriedade: TCampoPlanilha;
begin

  recLinha := TLinha.New;
  For intCnt := 0 to Self.Arquivo.Modelo.Campos.Count-1  Do
  Begin
    recCampo := recLinha.AddCampo;
    recPropriedade.NomeCampo  := Self.Arquivo.Modelo.Campos[intCnt].NomeCampo;
    recCampo.Propriedades := recPropriedade;
  End;
end;

procedure TValidacaoDadosImportacaoItemFatVenda.pSetarDados(const aLinha: ILinha);
var
  intCnt: Integer;
begin
  For intCnt := aLinha.Campos.Count-1 DownTo 0 Do
  Begin

    Case AnsiIndexStr(aLinha.Campos[intCnt].Propriedades.NomeCampo, arrCamposIteFatVenda)  Of
      0 : Begin
            FIndiceCodItem := intCnt;
            FItemFatVenda.ItemFatVenda.CodItem := fStrZero(fTiraCaracEspeciaisPonto(aLinha.Campos[intCnt].Propriedades.Conteudo), fTamCodIte);
          End;

      1 : Begin
            FIndiceQtdeItem := intCnt;
            Try
              FItemFatVenda.ItemFatVenda.QtdeItem := fStrToFloat(IIF(fEmptyStr(aLinha.Campos[intCnt].Propriedades.Conteudo),'0',aLinha.Campos[intCnt].Propriedades.Conteudo))
            Except
              FItemFatVenda.ItemFatVenda.QtdeItem := 0.00;
            End;
          End;

      2 : Begin
            FIndiceDestinoItem := intCnt;
            FItemFatVenda.ItemFatVenda.DestinoItem := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      3 : Begin
            FIndiceVlrUnitItem := intCnt;
            Try
              FItemFatVenda.ItemFatVenda.VlrUnitItem := fStrToFloat(IIF(fEmptyStr(aLinha.Campos[intCnt].Propriedades.Conteudo),'0',aLinha.Campos[intCnt].Propriedades.Conteudo));
            Except
              FItemFatVenda.ItemFatVenda.VlrUnitItem := 0.00;
            End;
          End;

      4 : Begin
            FIndiceVlrComDescon := intCnt;
            Try
              FItemFatVenda.ItemFatVenda.VlrComDescon := fStrToFloat(IIF(fEmptyStr(aLinha.Campos[intCnt].Propriedades.Conteudo),'0',aLinha.Campos[intCnt].Propriedades.Conteudo));
            Except
              FItemFatVenda.ItemFatVenda.VlrComDescon := 0.00;
            End;
          End;

      5 : Begin
            FIndiceDescontoItem := intCnt;
            Try
              FItemFatVenda.ItemFatVenda.DescontoItem := fStrToFloat(IIF(fEmptyStr(aLinha.Campos[intCnt].Propriedades.Conteudo),'0',aLinha.Campos[intCnt].Propriedades.Conteudo));
            Except
             FItemFatVenda.ItemFatVenda.DescontoItem  := 0.00;
            End;
          End;

      6 : Begin
            FIndiceTabPreCad := aLinha.Campos[intCnt].Propriedades.Posicao;
            FItemFatVenda.ItemFatVenda.TabPreCad := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      7 : Begin
            FIndiceComplItem := intCnt;
            FItemFatVenda.ItemFatVenda.ComplItem := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      8 : Begin
            FIndiceUnidadeItem := intCnt;
            FItemFatVenda.ItemFatVenda.UnidadeItem := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      9: Begin
            FIndiceEmpFat := intCnt;
            FItemFatVenda.ItemFatVenda.EmpFat := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      10: Begin
            FIndiceLoteArm := intCnt;
            FItemFatVenda.ItemFatVenda.LoteArm := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      11: Begin
            FIndiceLocRet := intCnt;
            FItemFatVenda.ItemFatVenda.LocRet := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      12: Begin
            FIndiceTpEntrega := intCnt;
            FItemFatVenda.ItemFatVenda.TpEntrega := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      13: Begin
            FIndiceMotivo := intCnt;
            FItemFatVenda.ItemFatVenda.Motivo := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      14: Begin
            FIndiceCliRetira := intCnt;
            FItemFatVenda.ItemFatVenda.CliRetira := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      15: Begin
            FIndiceDiasEntrega := intCnt;
            Try
              FItemFatVenda.ItemFatVenda.DiasEntrega := StrToInt(IIF(fEmptyStr(aLinha.Campos[intCnt].Propriedades.Conteudo),'0',aLinha.Campos[intCnt].Propriedades.Conteudo));
            Except
              FItemFatVenda.ItemFatVenda.DiasEntrega := 0;
            End;
          End;

      16: Begin
            FIndiceDtaEntrega := intCnt;
            FItemFatVenda.ItemFatVenda.strDtaEntrega := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      17: Begin
            FIndicePegou := intCnt;
            FItemFatVenda.ItemFatVenda.Pegou := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;

      18: Begin
            FIndiceBrinde := intCnt;
            FItemFatVenda.ItemFatVenda.Brinde := aLinha.Campos[intCnt].Propriedades.Conteudo;
          End;
    End;
  End;
end;

procedure TValidacaoDadosImportacaoItemFatVenda.pAnalisaInconsistenciaMultiploDeVenda(
  const aLinha: ILinha);
  Var
    fltMultiplo : Double;
begin
  If fEmptyStr(FItemFatVenda.ItemFatVenda.CodItem) Then
    Exit;
  If (FItemFatVenda.ItemFatVenda.QtdeItem <= 0) Then
    Exit;
  If (fCfgSis('MLTVEN', varString) <> '1') Then
    Exit;
  If (fMultiploValido(FItemFatVenda.ItemFatVenda.CodItem, FItemFatVenda.ItemFatVenda.QtdeItem, fltMultiplo)) Then
    Exit;
  pAdicionaInconsistencia(aLinha,
                          aLinha.Campos[FIndiceQtdeItem].Propriedades.Coluna,
                          aLinha.Campos[FIndiceQtdeItem].Propriedades.DescricaoCampo,
                          Format(cstValidacaoMultiploDeVenda, [fltMultiplo]));
end;

end.
