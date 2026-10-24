unit faturamento.Classes.ImpressaoLocEqu;

interface

uses
  Windows, Classes, Vcl.Controls,  Uni, DateUtils, SysUtils, System.Generics.Collections,
  cadastro.Model.ContratoLocacaoEquipamentos, untEditorFastImpressao, Forms;

Type

  TImpressaoContrato = Class
  private
    FObjContrato: TContratoLocacaoEquipamentos;
    FobjImpressaoIsp: TEditorFastImpressao;
    FstrLayPadrao: String;
    FMensagemRetorno: String;

    function fPreparaObjImpressaoIspE: Boolean;
    function fPreparaObjImpressaoIspS: Boolean;
    function GetCtr: TContratoLocacaoEquipamentos;
    procedure SetCtr(const AValue: TContratoLocacaoEquipamentos);
    function GetMsgRet: String;
    procedure SetMsgRet(const AValue: String);
  public
    constructor Create(const pContrato: TContratoLocacaoEquipamentos = Nil);
    destructor Destroy; override;

    function fImprimeComprovanteIspEnt(const ACodEql: String; ASeqEql: String): Boolean; overload;
    function fImprimeComprovanteIspSai(const ACodEql: String; ASeqEql: String): Boolean; overload;
    function fAddItemImpIspEnt(aItem: TItemContratoLocacaoEquipamentos): Boolean; overload;
    function fAddItemImpIspSai(aItem: TItemContratoLocacaoEquipamentos): Boolean; overload;
    function fAddItemImpIspEnt(const ACodEql: String; ASeqEql: String): Boolean; overload;
    function fAddItemImpIspSai(const ACodEql: String; ASeqEql: String): Boolean; overload;

    class function fRetornaModeloImpressao(const strStatus: String; const ablnProrrogacao: Boolean = False): String;
    class function fRetornaDiretorioPadraoContratos: String;

    property Contrato: TContratoLocacaoEquipamentos read GetCtr  write SetCtr;
    property MensagemRetorno: String read GetMsgRet write SetMsgRet;
  End;

implementation

uses
  TypesRel, untTypesSistema, untGravando, untFuncoesSimples, System.MaskUtils,
  untFuncoesGenerica;

constructor TImpressaoContrato.Create(const pContrato: TContratoLocacaoEquipamentos = Nil);
begin
  If Assigned(pContrato) Then
    FObjContrato := pContrato
  Else
    FObjContrato := TContratoLocacaoEquipamentos.Create;

  FobjImpressaoIsp := TEditorFastImpressao.Create(Nil);
end;

destructor TImpressaoContrato.Destroy;
begin
  If Assigned(FobjImpressaoIsp) Then
    FreeAndNil(FobjImpressaoIsp);

  inherited;
end;

function TImpressaoContrato.fAddItemImpIspEnt(
  aItem: TItemContratoLocacaoEquipamentos): Boolean;
begin
  Result := False;

  If aItem.InspecaoEntradaRealizada Then
  Begin
    If fEmptyStr(FobjImpressaoIsp.recDocume.strEquipamentos) Then
      FobjImpressaoIsp.recDocume.strEquipamentos := QuotedStr(aItem.AutInc)
    Else
      FobjImpressaoIsp.recDocume.strEquipamentos := FobjImpressaoIsp.recDocume.strEquipamentos + ',' + QuotedStr(aItem.AutInc);

    Result := True;
  End;
end;

function TImpressaoContrato.fAddItemImpIspSai(
  aItem: TItemContratoLocacaoEquipamentos): Boolean;
begin
  Result := False;

  If aItem.InspecaoSaidaRealizada Then
  Begin
    If fEmptyStr(FobjImpressaoIsp.recDocume.strEquipamentos) Then
      FobjImpressaoIsp.recDocume.strEquipamentos := QuotedStr(aItem.AutInc)
    Else
      FobjImpressaoIsp.recDocume.strEquipamentos := FobjImpressaoIsp.recDocume.strEquipamentos + ',' + QuotedStr(aItem.AutInc);

    Result := True;
  End;
end;

function TImpressaoContrato.fPreparaObjImpressaoIspE: Boolean;
begin
  FstrLayPadrao := fCampoTabela('LAY_CODLAY', 'LAYETI', ['LAY_TIPLAY', 'LAY_CODEMP', 'LAY_PADRAO'],
                                [ARR_TIPO_LAYOUT[tpeInspecaoEnt], VS_strCodEmp, 'S']);

  If fEmptyStr(FstrLayPadrao) Then
  Begin
    FMensagemRetorno := 'Não há layout disponível para impressão da inspeção de entrada!';
    Result := False;
    Exit;
  End;

  FobjImpressaoIsp.recDocume.strEquipamentos := '';
  FobjImpressaoIsp.recDocume.strNumDoc       := FObjContrato.NroContrato;
  FobjImpressaoIsp.recDocume.strCodEmp       := VS_strCodEmp;
  FobjImpressaoIsp.recDocume.blnInspecaoEnt  := True;
  FobjImpressaoIsp.recDocume.blnInspecaoSai  := False;
  FobjImpressaoIsp.tpeTipoEtiqueta           := tpeInspecaoEnt;
  Result := True;
end;

function TImpressaoContrato.fPreparaObjImpressaoIspS: Boolean;
begin
  FstrLayPadrao := fCampoTabela('LAY_CODLAY', 'LAYETI', ['LAY_TIPLAY', 'LAY_CODEMP', 'LAY_PADRAO'], [ARR_TIPO_LAYOUT[tpeInspecaoSai], VS_strCodEmp, 'S']);

  If fEmptyStr(FstrLayPadrao) Then
  Begin
    FMensagemRetorno := 'Não há layout disponível para impressão da inspeção de saída!';
    Result := False;
    Exit;
  End;

  FobjImpressaoIsp.recDocume.strEquipamentos := '';
  FobjImpressaoIsp.recDocume.strNumDoc       := FObjContrato.NroContrato;
  FobjImpressaoIsp.recDocume.strCodEmp       := VS_strCodEmp;
  FobjImpressaoIsp.recDocume.blnInspecaoSai  := True;
  FobjImpressaoIsp.recDocume.blnInspecaoEnt  := False;
  FobjImpressaoIsp.tpeTipoEtiqueta           := tpeInspecaoSai;

  Result := True;
end;

function TImpressaoContrato.GetCtr: TContratoLocacaoEquipamentos;
begin
  Result := FObjContrato;
end;

function TImpressaoContrato.GetMsgRet: String;
begin
  Result := FMensagemRetorno;
end;

procedure TImpressaoContrato.SetCtr(const AValue: TContratoLocacaoEquipamentos);
begin
  FObjContrato := AValue;
end;

procedure TImpressaoContrato.SetMsgRet(const AValue: String);
begin
  FMensagemRetorno := AValue;
end;

function TImpressaoContrato.fAddItemImpIspEnt(const ACodEql: String; ASeqEql: String): Boolean;
var
  item: TItemContratoLocacaoEquipamentos;
begin
  item := FObjContrato.fRetornaItemContrato(ACodEql);

  If item.DataInspecaoEntrada <= 0 Then
    Exit(False);

  Result := fAddItemImpIspEnt(item);
end;

function TImpressaoContrato.fAddItemImpIspSai(const ACodEql: String; ASeqEql: String): Boolean;
var
  item: TItemContratoLocacaoEquipamentos;
begin
  item := FObjContrato.fRetornaItemContrato(ACodEql);
  Result := fAddItemImpIspSai(item);
end;

function TImpressaoContrato.fImprimeComprovanteIspEnt(
  const ACodEql: String; ASeqEql: String): Boolean;
begin
  If Not fPreparaObjImpressaoIspE Then
  Begin
    Result := False;
    Exit;
  End;

  If Not fAddItemImpIspEnt(ACodEql, ASeqEql) Then
  Begin
    Result := False;
    Exit;
  End;

  If fEmptyStr(FobjImpressaoIsp.recDocume.strEquipamentos) Then
  Begin
    Result := False;
    Exit;
  End;

  Result := FobjImpressaoIsp.fImprimeDocumento;
end;

function TImpressaoContrato.fImprimeComprovanteIspSai(
  const ACodEql: String; ASeqEql: String): Boolean;
begin

  If fEmptyStr(ACodEql) Then
  Begin
    Result := False;
    Exit;
  End;

  If Not fPreparaObjImpressaoIspS Then
  Begin
    Result := False;
    Exit;
  End;

  If Not fAddItemImpIspSai(ACodEql, ASeqEql) Then
  Begin
    Result := False;
    Exit;
  End;

  If fEmptyStr(FobjImpressaoIsp.recDocume.strEquipamentos) Then
  Begin
    Result := False;
    Exit;
  End;

  Result := FobjImpressaoIsp.fImprimeDocumento(tpaNormal, '', 'Inspecao_'+ ACodEql +'.pdf');
end;

class function TImpressaoContrato.fRetornaDiretorioPadraoContratos: String;
var
  strDirModeloImp: String;
begin
  strDirModeloImp := fCfgSis('PATCTR', VarString);

  If fEmptyStr(strDirModeloImp) Then
    strDirModeloImp := ExtractFilePath(Application.ExeName) +  'ModelosRelatoriosClientes\Modelos_Locacao_Equipamentos\';

  If Not DirectoryExists(strDirModeloImp) Then
    CreateDir(strDirModeloImp);

  Result := strDirModeloImp;
end;

class function TImpressaoContrato.fRetornaModeloImpressao(const strStatus: String; const ablnProrrogacao: Boolean = False): String;
var
  strNomOri: String;
  strDirModeloImp: String;
  strDirPadrao: String;
  strNomModeloDoc: String;
begin
  strDirPadrao := ExtractFilePath(Application.ExeName);
  strDirModeloImp := fRetornaDiretorioPadraoContratos;

  If ablnProrrogacao Then
  Begin
    strNomModeloDoc := 'CONTRATO_PRORROGACAO_LOCACAO_EQUIPAMENTOS.DOC';
  End
  Else
  Begin
    If strStatus = 'O' Then
      strNomModeloDoc := 'ORCAMENTO_LOCACAO_EQUIPAMENTOS.DOC'
    Else
      strNomModeloDoc := 'CONTRATO_LOCACAO_EQUIPAMENTOS.DOC';
  End;

  strNomOri := strDirModeloImp + strNomModeloDoc;
  If Not FileExists(strNomOri) Then
  Begin
    strNomOri := strDirPadrao + strNomModeloDoc;
    If Not FileExists(strNomOri) Then
      strNomOri := strDirPadrao + 'CONTRATO_LOCACAO_EQUIPAMENTOS.DOC';
  End;

  Result := strNomOri;
end;

end.
