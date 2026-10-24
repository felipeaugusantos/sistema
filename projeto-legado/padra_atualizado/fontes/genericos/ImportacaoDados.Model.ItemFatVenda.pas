unit ImportacaoDados.Model.ItemFatVenda;

interface

Uses
  ImportacaoDados.Interfaces, ImportacaoDados.Model.ModeloArquivo,
  Classes, SysUtils, cxProgressBar, System.Generics.Collections, DB, Uni, Variants;

Type

  TItemFatVenda = class
  private
    FCodItem:       String;
    FQtdeItem:      Double;
    FDestinoItem:   String;
    FVlrUnitItem:   Double;
    FVlrComDescon:  Double;
    FDescontoItem:  Double;
    FTabPreCad:     String;
    FComplItem:     String;
    FUnidadeItem:   String;
    FEmpFat:        String;
    FLoteArm:       String;
    FLocRet:        String;
    FTpEntrega:     String;
    FMotivo:        String;
    FCliRetira:     String;
    FDiasEntrega:   Integer;
    FDtaEntrega:    TDateTime;
    FPegou:         String;
    FBrinde:        String;
    FStrDtaEntrega: String;
  public
    constructor Create;
    destructor Destroy; override;

    class function fNew: TItemFatVenda;

    property CodItem:       String     read FCodItem       write FCodItem;
    property QtdeItem:      Double     read FQtdeItem      write FQtdeItem;
    property DestinoItem:   String     read FDestinoItem   write FDestinoItem;
    property VlrUnitItem:   Double     read FVlrUnitItem   write FVlrUnitItem;
    property VlrComDescon:  Double     read FVlrComDescon  write FVlrComDescon;
    property DescontoItem:  Double     read FDescontoItem  write FDescontoItem;
    property TabPreCad:     String     read FTabPreCad     write FTabPreCad;
    property ComplItem:     String     read FComplItem     write FComplItem;
    property UnidadeItem:   String     read FUnidadeItem   write FUnidadeItem;
    property EmpFat:        String     read FEmpFat        write FEmpFat;
    property LoteArm:       String     read FLoteArm       write FLoteArm;
    property LocRet:        String     read FLocRet        write FLocRet;
    property TpEntrega:     String     read FTpEntrega     write FTpEntrega;
    property Motivo:        String     read FMotivo        write FMotivo;
    property CliRetira:     String     read FCliRetira     write FCliRetira;
    property DiasEntrega:   Integer    read FDiasEntrega   write FDiasEntrega;
    property DtaEntrega:    TDateTime  read FDtaEntrega    write FDtaEntrega;
    property Pegou:         String     read FPegou         write FPegou;
    property Brinde:        String     read FBrinde        write FBrinde;
    property StrDtaEntrega: String     read FStrDtaEntrega write FStrDtaEntrega;
  End;

  TModeloImportacaoItemFatVenda = class(TModeloArquivoImportacao)
  private
    FCamposPadrao: TList<TCampoPlanilha>;
    function fExibeUnidade : Boolean;
    function fRetornaCaptionLoteArm : String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fCarregarCamposPadrao: Boolean; override;
    function fCarregarCampos: Boolean; override;
    procedure pDefineCamposPadrao; override;
  End;

implementation

uses
  untFuncoesSimples, untFuncoesGenerica, StrUtils;


{ TItemFatVenda }

constructor TItemFatVenda.Create;
begin
  inherited;
end;

destructor TItemFatVenda.Destroy;
begin
  inherited;
end;

class function TItemFatVenda.fNew: TItemFatVenda;
begin
  Result := Self.Create;
end;

{ TModeloImportacaoItemFatVenda }

constructor TModeloImportacaoItemFatVenda.Create;
begin
  inherited;

  FCamposPadrao := TList<TCampoPlanilha>.Create;
  pDefineCamposPadrao;
end;

destructor TModeloImportacaoItemFatVenda.Destroy;
begin
  inherited;

  FreeAndNil(FCamposPadrao);
end;

function TModeloImportacaoItemFatVenda.fCarregarCampos: Boolean;
Begin
  Result := False;

  inherited;
End;

function TModeloImportacaoItemFatVenda.fCarregarCamposPadrao: Boolean;
var
  recCampo: ICamposModeloArquivo;
  intCnt: Integer;
begin
  inherited;

  pLimparCampos;
  Try
    For intCnt := 0 to FCamposPadrao.Count-1 Do
    Begin
      recCampo := Self.AddCampo;
      recCampo.NomeCampo   := FCamposPadrao[intCnt].NomeCampo;
      recCampo.Descricao   := FCamposPadrao[intCnt].DescricaoCampo;
      recCampo.Coluna      := FCamposPadrao[intCnt].Coluna;
      recCampo.Obrigatorio := FCamposPadrao[intCnt].Obrigatorio;
      recCampo.TipoCampo   := FCamposPadrao[intCnt].TipoCampo;
      recCampo.Tamanho     := FCamposPadrao[intCnt].Tamanho;
      recCampo.Posicao     := intCnt;
    End;
    Result := True;
  Except
    Result := False;
  End;

end;

procedure TModeloImportacaoItemFatVenda.pDefineCamposPadrao;
Var intCol         : Integer;
begin
  inherited;

  pLimparCampos;
  FCamposPadrao.Clear;

  FCamposPadrao.Add(fAdicionarCampo(cstCodItem,      'Código do Item',                              'A',  'S', ftString, 20));
  FCamposPadrao.Add(fAdicionarCampo(cstQtdeItem,     'Quantidade',                                  'B',  'S', ftFloat, 15));
  FCamposPadrao.Add(fAdicionarCampo(cstDestinoItem,  'Destino (R-RETIRA; E=ENTREGA)',               'C',  'S', ftString, 1));
  FCamposPadrao.Add(fAdicionarCampo(cstVlrUnitItem,  'Valor Unitário',                              'D',  'N', ftFloat, 15));
  FCamposPadrao.Add(fAdicionarCampo(cstVlrComDescon, 'Valor Unitário c/ Dscto',                     'E',  'N', ftFloat, 15));
  FCamposPadrao.Add(fAdicionarCampo(cstDescontoItem, 'Desconto',                                    'F',  'N', ftFloat, 15));

  intCol := 6;

  If (fCfgSis('TABITE', varBoolean) And (fCfgSis('UTAPTB') = 0)) Then
  Begin
    intCol := intCol + 1;
    FCamposPadrao.Add(fAdicionarCampo(cstTabPreCad,  'Tabela de Preço do Cadastro de Produtos',     fGetLetraAlfa(intCol),  'N', ftString, 1));
  End;

  If (fCfgSis('FATCOM', varBoolean)) Then
  Begin
    intCol := intCol + 1;
    FCamposPadrao.Add(fAdicionarCampo(cstComplItem,  'Complemento do Item',                         fGetLetraAlfa(intCol),  'N', ftString, 30));
  End;

  If fExibeUnidade Then
  Begin
    intCol := intCol + 1;
    FCamposPadrao.Add(fAdicionarCampo(cstUnidadeItem,  'Unidade',                                   fGetLetraAlfa(intCol),  'N', ftString, 2));
  End;

  If (fCfgSis('EMPFAT', varBoolean)) Then
  Begin
    intCol := intCol + 1;
    FCamposPadrao.Add(fAdicionarCampo(cstEmpFat,      'Empresa de Faturamento',                     fGetLetraAlfa(intCol),  'N', ftString, 3));
  End;

  intCol := intCol + 1;
  FCamposPadrao.Add(fAdicionarCampo(cstLoteArm,     fRetornaCaptionLoteArm,                          fGetLetraAlfa(intCol),  'N', ftString, 20));

  If (fCfgSis('LOCRET', varBoolean)) Then
  Begin
    intCol := intCol + 1;
    FCamposPadrao.Add(fAdicionarCampo(cstLocRet,      'Local Retira (C-CAIXA; E=EXPEDIÇÃO)',        fGetLetraAlfa(intCol),  'N', ftString, 1));
  End;

  If (fCfgSis('ENTFUT', varBoolean)) Then
  Begin
    intCol := intCol + 1;
    FCamposPadrao.Add(fAdicionarCampo(cstTpEntrega,   'Tipo Entrega (F-FUTURA; I-IMEDIATA)',        fGetLetraAlfa(intCol),  'N', ftString, 1));

    intCol := intCol + 1;
    FCamposPadrao.Add(fAdicionarCampo(cstMotivo,       'Motivo (F-Falta Produto; A-Aguardando Cliente; P-Previsão de Entrega)',   fGetLetraAlfa(intCol),  'N', ftString, 1));
  End;


  If (fCfgSis('ENTFUT', varBoolean) And fCfgSis('CLBUEF', varBoolean)) Then
  Begin
    intCol := intCol + 1;
    FCamposPadrao.Add(fAdicionarCampo(cstCliRetira,   'Cliente vai Retirar (S-SIM; N-NÃO)',         fGetLetraAlfa(intCol),  'N', ftString, 1));
  End;

  intCol := intCol + 1;
  FCamposPadrao.Add(fAdicionarCampo(cstDiasEntrega,  'Dias Entrega',                                fGetLetraAlfa(intCol),  'N', ftInteger, 4));

  intCol := intCol + 1;
  FCamposPadrao.Add(fAdicionarCampo(cstDtaEntrega,   'Data Entrega (dd/mm/aaaa)',                                fGetLetraAlfa(intCol),  'N', ftString, 10));

  If (fCfgSis('PEGPED', varBoolean))  Then
  Begin
    intCol := intCol + 1;
    FCamposPadrao.Add(fAdicionarCampo(cstPegou,       'Pegou? (S-SIM; N-NÃO)',                      fGetLetraAlfa(intCol),  'N', ftString, 1));
  End;

  If (fCfgSis('USABRI', varBoolean))  Then
  Begin
    intCol := intCol + 1;
    FCamposPadrao.Add(fAdicionarCampo(cstBrinde,      'Brinde? (S-SIM; N-NÃO)',                     fGetLetraAlfa(intCol),  'N', ftString, 1));
  End;
end;

function TModeloImportacaoItemFatVenda.fExibeUnidade : Boolean;
Begin
  If (not fCfgSis('EDIFAT', varBoolean)) And
     (not fCfgSis('EDITIN', varBoolean)) And
     (Copy(fCfgSis('ITEESP', varString), 1, 2) = 'NN') Then
    Result :=  False
  Else
    Result :=  True;
End;


function TModeloImportacaoItemFatVenda.fRetornaCaptionLoteArm : String;
Begin
  If (fCfgSis('CTLEST') = 1) Then
    Result := 'Lote'
  Else
    Result := 'Armazen.';
End;

end.


