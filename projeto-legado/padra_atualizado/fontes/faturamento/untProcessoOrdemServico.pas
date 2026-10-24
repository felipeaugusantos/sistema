unit untProcessoOrdemServico;

interface

uses
  Classes,
  SysUtils,
  System.Variants,
  Vcl.Graphics,
  Vcl.Controls,
  cxGridBandedTableView, cxGridDBBandedTableView,
  cxTextEdit,
  cxLookAndFeelPainters,
  cxMemo,
  cxGridCustomTableView,
  cxGraphics,
  cxEdit,
  cxGridCustomView,
  cxEditRepositoryItems,
  uni,
  Data.DB,
  untTypesSistema,
  cxImageComboBox,
  cxLabel,
  untFuncoesGenerica;

type
  ExceptionMessage = class(Exception);
  TStatusProcesso  = (stpNeutro, stpRealizar, stpRealizado, stpVisualizar, stpImprimir);
  TArrColumn = Array Of TcxGridDBBandedColumn;
  TArrCampo = Array Of Record
                         strFieldName,
                         strCaption,
                         strClassName: String;
                         aliAlignmentHorz: TAlignment;
                         intWidth: Integer;
                       end;

  TRealizarProcessoEvent   = procedure(ANumeroOS, ACodEmp, ANomeCampo: String)                           of object;
  TVisualizarProcessoEvent = procedure(ANumeroOS, ACodEmp, ANomeCampo: String)                           of object;
  TImprimirProcessoEvent   = procedure(ANumeroOS, ACodEmp, ANomeCampo: String)                           of object;
  TAposRealizarEvent       = procedure(AVerificaStatus: Boolean = False)                                 of object;
  TGetStatusProcesso       = function(AValor: String; ANomeCampo: String = ''): TStatusProcesso          of object;
  TGetProcessoRealizadoDB  = function(ANumeroOS, ACodEmp: String): Boolean                               of object;

  TProcessoComum = class
  const
    COR_REALIZADO   = $00804000;
    COR_REALIZAR    = $000000EC;
  private
    FTipoProcesso               : TTipoProcessosFlxConEqu;
    FProcessando                : Boolean;
    FColumn                     : TArrColumn;
    FComumAnterior              : TProcessoComum;
    FComumSeguinte              : TProcessoComum;
    FComumAntAnterior           : TProcessoComum;
    FComumAntAnterior2          : TProcessoComum;
    FChaveDireitoAcessoRealizar : String;
    FDataFieldName              : TArrCampo;
    FTitulo                     : String;
    FAtualizarGrid              : Boolean;

    FOnRealizar                 : TRealizarProcessoEvent;
    FOnVisualizar               : TVisualizarProcessoEvent;
    FOnImprimir                 : TImprimirProcessoEvent;
    FOnAposRealizar             : TAposRealizarEvent;
    FGetStatus                  : TGetStatusProcesso;
    FGetRealizadoDB             : TGetProcessoRealizadoDB;

    FPais                       : TPais;

    procedure pMouseMoveAuxiliar(AValor: String; AGridSite: TcxGridSite; X, Y, ARecordIndex, AColumnIndex: Integer;
                                 AGridView: TcxGridDBBandedTableView);
  public
    FCxgFluxoTBV: TcxGridDBBandedTableView;

    function fColunaSoDisplay(AIndice: Integer): Boolean;
    function fVerificaColunaAnterior(ANumeroOS, ACodEmp: String): Boolean;
    function fVerificaColunaReprovar(ANumeroOS, ACodEmp: String): Boolean;
    function fVerificaColunaManutencao(ANumeroOS, ACodEmp: String): Boolean;
    function fVerificaColunaApontamento(ANumeroOS, ACodEmp: String): Boolean;
    function fMensagemProsseguir: String;
    function fMensagemManutencao: String;
    function fMensagemReprovar: String;
    procedure pSetaNumeroColunas(ATamanho: Integer);
    procedure pFormataCelula(ASender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure pIncluiColuna(APosicao: Integer; AFieldName, ACaption, AClassName: String; AAlignmentHorz: TAlignment; AWidth: Integer);
    procedure pMouseMove(AGridSite: TcxGridSite; X, Y: Integer);
    procedure pExecuta(AValor, ANumeroOS, ACodEmp, ANomeCampo: String);
    procedure pRealizar(ANumeroOS, ACodEmp, ANomeCampo : String);
    procedure pVisualizar(ANumeroOS, ACodEmp, ANomeCampo : String);
    procedure pImprimir(ANumeroOS, ACodEmp, ANomeCampo : String);

    property tprTipoProcesso               : TTipoProcessosFlxConEqu  read FTipoProcesso               write FTipoProcesso;
    property strChaveDireitoAcessoRealizar : String                   read FChaveDireitoAcessoRealizar write FChaveDireitoAcessoRealizar;
    property stlDataFieldName              : TArrCampo                read FDataFieldName              write FDataFieldName;
    property strTitulo                     : String                   read FTitulo                     write FTitulo;
    property objColumn                     : TArrColumn               read FColumn                     write FColumn;
    property objProcessoComumAnterior      : TProcessoComum           read FComumAnterior              write FComumAnterior;
    property objProcessoComumSeguinte      : TProcessoComum           read FComumSeguinte              write FComumSeguinte;
    property objProcessoComumAntAnterior   : TProcessoComum           read FComumAntAnterior           write FComumAntAnterior;
    property objProcessoComumAntAnterior2  : TProcessoComum           read FComumAntAnterior2          write FComumAntAnterior2;

    property OnRealizar                    : TRealizarProcessoEvent   read FOnRealizar                 write FOnRealizar;
    property OnVisualizar                  : TVisualizarProcessoEvent read FOnVisualizar               write FOnVisualizar;
    property OnImprimir                    : TImprimirProcessoEvent   read FOnImprimir                 write FOnImprimir;
    property OnAposRealizar                : TAposRealizarEvent       read FOnAposRealizar             write FOnAposRealizar;
    property GetStatus                     : TGetStatusProcesso       read FGetStatus                  write FGetStatus;
    property GetRealizadoDB                : TGetProcessoRealizadoDB  read FGetRealizadoDB             write FGetRealizadoDB;

    constructor Create;
    destructor Destroy;  Override;
  end;

  TProcessoOrdemServico = class
  private
    FComum: TProcessoComum;
    FCxgFluxoTBV: TcxGridDBBandedTableView;
    function fCampoSemExecuta(strCampo: String): Boolean;
    procedure pGetPropertiesAuxilar(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
              var AProperties: TcxCustomEditProperties; strValor: String);
  public
    cxEditRepositoryTextItem: TcxEditRepositoryTextItem;
    cxEditRepositoryImageComboBoxItem: TcxEditRepositoryImageComboBoxItem;
    cxEditRepositoryMemoItem: TcxEditRepositoryMemoItem;

    procedure pConfiguraColumn(cxgGrid: TcxGridDBBandedTableView; intBandIndex: Integer); virtual;
    procedure pGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
               var AProperties: TcxCustomEditProperties);
    property objComum : TProcessoComum read FComum;

    Constructor Create;
    Destructor Destroy; override;
  end;

  TProcessoNumOS = class sealed(TProcessoOrdemServico)
  const
    DATA_FIELD_NAME_STATUSOS    = 'STATUS_OS';
    DATA_FIELD_NAME_NUMEROOS    = 'NUMERO_OS';

    TITULO                      = 'OS';
  private
    function getProcessoComum: TProcessoComum;
    function fGetStatus(AValor: String; ANomeCampo: String = ''): TStatusProcesso;
  public
    property objComum : TProcessoComum read getProcessoComum;

    constructor Create;
  end;

  TProcessoDadosOS = class sealed(TProcessoOrdemServico)
  const
    DATA_FIELD_NAME_PROTOCOLO    = 'PROTOCOLO';
    DATA_FIELD_NAME_CONSULTA     = 'CONSULTA_OS';
    DATA_FIELD_NAME_EDITAR       = 'EDITAR_OS';
    DATA_FIELD_NAME_IMP          = 'IMP';
    DATA_FIELD_NAME_ETI          = 'ETI';
    DATA_FIELD_NAME_TRESP        = 'TRESP';
    DATA_FIELD_NAME_TDEV         = 'TDEV';
    DATA_FIELD_NAME_ORDEXE       = 'ORDEXE';
    DATA_FIELD_NAME_EMP          = 'EMP';
    DATA_FIELD_NAME_DTINC        = 'DTINC';
    DATA_FIELD_NAME_CLIENTE      = 'CLIENTE';
    DATA_FIELD_NAME_CPFCNPJ      = 'CPFCNPJ';
    DATA_FIELD_NAME_EQUIPAMENTO  = 'EQUIPAMENTO';
    DATA_FIELD_NAME_MARCA        = 'MARCA';
    DATA_FIELD_NAME_STATUS       = 'STATUS';
    DATA_FIELD_NAME_SITUACAO     = 'SITUACAO';
    DATA_FIELD_NAME_COMPLEMENTO  = 'COMPLEMENTO';
    DATA_FIELD_NAME_OBSERVACOES  = 'OBSERVACOES';
    DATA_FIELD_NAME_MOTREPR      = 'MOTREPR';
    DATA_FIELD_NAME_HISTSTATUS   = 'HIST_STATUS';
    DATA_FIELD_NAME_HISTETAPAS   = 'HIST_ETAPAS';
    DATA_FIELD_NAME_HISTFAT      = 'HIST_FAT';
    DATA_FIELD_NAME_NFREME       = 'NFREME';
    DATA_FIELD_NAME_DTENTR_EQUIP = 'DTENTEQ';
    DATA_FIELD_NAME_DIG_ENTREG   = 'DIG_ENTREG';
    DATA_FIELD_NAME_DTFIN_MAN    = 'DTFINM_AN';
    DATA_FIELD_NAME_CON_PAGTO    = 'CON_PAGTO';
    DATA_FIELD_NAME_FOR_PAGTO    = 'FOR_PAGTO';

    TITULO                       = 'Dados da Ordem de Serviço';
  private
    function getProcessoComum: TProcessoComum;
    function fGetStatus(AValor: String; ANomeCampo: String = ''): TStatusProcesso;
    procedure pOnVisualizar(ANumeroOS, ACodEmp, ANomeCampo: String);
    procedure pOnImprimir(ANumeroOS, ACodEmp, ANomeCampo: String);
    procedure pCriaColunasImpressao(var intColumn: integer);

    procedure pVisualizarHistStatus(ANumeroOS, ACodEmp: String);
    procedure pVisualizarHistEtapas(ANumeroOS, ACodEmp: String);
    procedure pVisualizarHistFaturamento(ANumeroOS, ACodEmp: String);
  public
    property objComum : TProcessoComum read getProcessoComum;

    constructor Create;
  end;

  TProcessoDocsFiscais = class sealed(TProcessoOrdemServico)
  const
    DATA_FIELD_NAME_ENT = 'DOCS_FISCAIS_RELACIONADOS_ENT';
    DATA_FIELD_NAME_SAI = 'DOCS_FISCAIS_RELACIONADOS_SAI';
    TITULO              = 'Docs. Fiscais Relacionados';
  private
    function getProcessoComum: TProcessoComum;
    function fGetStatus(AValor: String; ANomeCampo: String = ''): TStatusProcesso;
    function fGetRealizadoDB(ANumeroOS, ACodEmp: String): Boolean;
  public
    property objComum : TProcessoComum read getProcessoComum;

    constructor Create;
  end;

  TProcessoDefPrdSer = class sealed(TProcessoOrdemServico)
  const
    DATA_FIELD_NAME = 'DEFEITOS_PRODUTOS_SERVICOS';
    TITULO          = 'Defeitos/Produtos/Serviços';
  private
    function getProcessoComum: TProcessoComum;
    function fGetStatus(AValor: String; ANomeCampo: String = ''): TStatusProcesso;
    function fGetRealizadoDB(ANumeroOS, ACodEmp: String): Boolean;
  public
    property objComum : TProcessoComum read getProcessoComum;

    constructor Create;
  end;

  TProcessoOrcamento = class sealed(TProcessoOrdemServico)
  const
    DATA_FIELD_NAME = 'ORCAMENTO';
    TITULO          = 'Orçamento';
  private
    function getProcessoComum: TProcessoComum;
    function fGetStatus(AValor: String; ANomeCampo: String = ''): TStatusProcesso;
    function fGetRealizadoDB(ANumeroOS, ACodEmp: String): Boolean;
  public
    property objComum : TProcessoComum read getProcessoComum;

    constructor Create;
  end;

  TProcessoAprovar = class sealed(TProcessoOrdemServico)
  const
    DATA_FIELD_NAME = 'APROVAR';
    TITULO          = 'Aprovar';
  private
    function getProcessoComum: TProcessoComum;
    function fGetStatus(AValor: String; ANomeCampo: String = ''): TStatusProcesso;
    function fGetRealizadoDB(ANumeroOS, ACodEmp: String): Boolean;
  public
    property objComum : TProcessoComum read getProcessoComum;

    constructor Create;
  end;

  TProcessoReprovar = class sealed(TProcessoOrdemServico)
  const
    DATA_FIELD_NAME = 'REPROVAR';
    TITULO          = 'Reprovar';
  private
    function getProcessoComum: TProcessoComum;
    function fGetStatus(AValor: String; ANomeCampo: String = ''): TStatusProcesso;
    function fGetRealizadoDB(ANumeroOS, ACodEmp: String): Boolean;
  public
    property objComum : TProcessoComum read getProcessoComum;

    constructor Create;
  end;

  TProcessoManutencao = class sealed(TProcessoOrdemServico)
  const
    DATA_FIELD_NAME = 'MANUTENCAO';
    TITULO          = 'Manutenção';
  private
    function getProcessoComum: TProcessoComum;
    function fGetStatus(AValor: String; ANomeCampo: String = ''): TStatusProcesso;
    function fGetRealizadoDB(ANumeroOS, ACodEmp: String): Boolean;
  public
    property objComum : TProcessoComum read getProcessoComum;

    constructor Create;
  end;

  TProcessoApontamento = class sealed(TProcessoOrdemServico)
  const
    DATA_FIELD_NAME = 'APONTAMENTO';
    TITULO          = 'Apont. de Horas';
  private
    function getProcessoComum: TProcessoComum;
    function fGetStatus(AValor: String; ANomeCampo: String = ''): TStatusProcesso;
    function fGetRealizadoDB(ANumeroOS, ACodEmp: String): Boolean;
  public
    property objComum : TProcessoComum read getProcessoComum;

    constructor Create;
  end;

  TProcessoFinalizar = class sealed(TProcessoOrdemServico)
  const
    DATA_FIELD_NAME = 'FINALIZAR';
    TITULO          = 'Finalizar';
  private
    function getProcessoComum: TProcessoComum;
    function fGetStatus(AValor: String; ANomeCampo: String = ''): TStatusProcesso;
    function fGetRealizadoDB(ANumeroOS, ACodEmp: String): Boolean;
  public
    property objComum : TProcessoComum read getProcessoComum;

    constructor Create;
  end;

  TProcessoRetirar = class sealed(TProcessoOrdemServico)
  const
    DATA_FIELD_NAME = 'RETIRAR';
    TITULO          = 'Retirar';
  private
    function getProcessoComum: TProcessoComum;
    function fGetStatus(AValor: String; ANomeCampo: String = ''): TStatusProcesso;
  public
    property objComum : TProcessoComum read getProcessoComum;

    constructor Create;
  end;

  TProcessoGarantia = class sealed(TProcessoOrdemServico)
  const
    DATA_FIELD_NAME_STAGAR = 'STATUS_GA';
    DATA_FIELD_NAME_TMPGAR = 'TEMPO_GA';
    DATA_FIELD_NAME_NOSFAB = 'NOSFAB';
    TITULO                 = 'Garantia';
  private
    function getProcessoComum: TProcessoComum;
    function fGetStatus(AValor: String; ANomeCampo: String = ''): TStatusProcesso;
  public
    property objComum : TProcessoComum read getProcessoComum;

    constructor Create;
  end;

  TProcessoFinalizacaoOS = class sealed(TProcessoOrdemServico)
  const
    DATA_FIELD_NAME_STAFIN = 'STATUS_FI';
    DATA_FIELD_NAME_TMPFIN = 'TEMPO_FI';
    TITULO                 = 'Finalização da OS';
  private
    function getProcessoComum: TProcessoComum;
    function fGetStatus(AValor: String; ANomeCampo: String = ''): TStatusProcesso;
  public
    property objComum : TProcessoComum read getProcessoComum;

    constructor Create;
  end;

  TProcessoTaxaArmazenamento = class sealed(TProcessoOrdemServico)
  const
    DATA_FIELD_NAME_TX_ARM = 'TOTAL_TAXA';
    TITULO                 = 'Taxa Armazenamento';
  private
    function getProcessoComum: TProcessoComum;
    function fGetStatus(AValor: String; ANomeCampo: String = ''): TStatusProcesso;
  public
    property objComum : TProcessoComum read getProcessoComum;

    constructor Create;
  end;

implementation

uses
  Windows,
  Vcl.StdCtrls,
  cxButtonEdit,
  untFuncoesSimples,
  untFuncoesRel,
  strUtils,
  untFatManConsertoEquip;

{ TProcessoOrdemServico }

constructor TProcessoOrdemServico.Create;
begin
  inherited;

  cxEditRepositoryImageComboBoxItem      := Nil;
  FComum := TProcessoComum.Create();
end;

destructor TProcessoOrdemServico.Destroy;
begin
  pFreeAndNil(FComum);
  inherited;
end;

function TProcessoOrdemServico.fCampoSemExecuta(strCampo: String): Boolean;
begin
  Result := Pos(strCampo, 'NUMERO_OS-EMP-DTINC-CLIENTE-CPFCNPJ-EQUIPAMENTO-MARCA-' +
                          'STATUS-SITUACAO-COMPLEMENTO-OBSERVACOES-MOTREPR-PROTOCOLO-' +
                          'STATUS_GA-TEMPO_GA-STATUS_FI-TEMPO_FI-NFREME-DTENTEQ-DIG_ENTREG-DTFIN_MAN') > 0;
end;

procedure TProcessoOrdemServico.pConfiguraColumn(
  cxgGrid: TcxGridDBBandedTableView; intBandIndex: Integer);
Var
  cxColumn: TcxGridDBBandedColumn;
  intCount: Integer;
begin
  inherited;

  FCxgFluxoTBV := cxgGrid;
  FComum.FCxgFluxoTBV := cxgGrid;

  For intCount := Low(FComum.stlDataFieldName) To High(FComum.stlDataFieldName) Do
  Begin
    cxColumn := cxgGrid.CreateColumn;

    cxColumn.OnCustomDrawCell := FComum.pFormataCelula;
    cxColumn.OnGetProperties  := pGetProperties;

    cxColumn.DataBinding.FieldName := FComum.stlDataFieldName[intCount].strFieldName;
    cxColumn.Position.BandIndex := intBandIndex;
    cxColumn.Caption := FComum.stlDataFieldName[intCount].strCaption;
    cxColumn.Visible := Not FComum.stlDataFieldName[intCount].strCaption.IsEmpty;
    cxColumn.Name := FComum.stlDataFieldName[intCount].strFieldName;

    cxColumn.HeaderAlignmentHorz := taCenter;
    cxColumn.Width := FComum.stlDataFieldName[intCount].intWidth;
    cxColumn.PropertiesClassName := FComum.stlDataFieldName[intCount].strClassName;

    If cxColumn.PropertiesClassName = 'TcxTextEditProperties' Then
    Begin
      cxColumn.Properties := cxEditRepositoryTextItem.Properties;
      (cxColumn.Properties as TcxTextEditProperties).Alignment.Horz := FComum.stlDataFieldName[intCount].aliAlignmentHorz;
      (cxColumn.Properties as TcxTextEditProperties).Alignment.Vert := taVCenter;
      (cxColumn.Properties as TcxTextEditProperties).CharCase := ecUpperCase;
    End
    Else If cxColumn.PropertiesClassName = 'TcxLabelProperties' Then
    Begin
      (cxColumn.Properties as TcxLabelProperties).Alignment.Horz := FComum.stlDataFieldName[intCount].aliAlignmentHorz;
      (cxColumn.Properties as TcxLabelProperties).Alignment.Vert := taVCenter;
      (cxColumn.Properties as TcxLabelProperties).ReadOnly := True;
    End
    Else If cxColumn.PropertiesClassName = 'TcxImageComboBoxProperties' Then
    Begin
      cxColumn.Properties := cxEditRepositoryImageComboBoxItem.Properties;
      cxColumn.Options.ShowEditButtons := isebNever;
      cxColumn.Properties.ReadOnly := True;
    End
    Else If cxColumn.PropertiesClassName = 'TcxMemoEditProperties' Then
    Begin
      cxColumn.Properties := cxEditRepositoryMemoItem.Properties;
      (cxColumn.Properties as TcxMemoProperties).CharCase := ecUpperCase;
    End;
  End;
end;

procedure TProcessoOrdemServico.pGetProperties(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
Var
  LValor: String;
begin
  Try
    If Not Assigned(ARecord) Then
      Exit;

    If ARecord.Index < 0 Then
    Begin
      AProperties := cxEditRepositoryTextItem.Properties;
      Exit;
    End;

    If fCampoSemExecuta(TcxGridDBBandedColumn(Sender).DataBinding.FieldName) Then
      Exit;

    If ARecord.IsData And
       (ARecord.Index >= 0) And
       Assigned(FComum) And
       Assigned(FComum.FGetStatus) And
       Assigned(cxEditRepositoryImageComboBoxItem) Then
    Begin
      LValor := Trim(VarToStr(ARecord.Values[Sender.Index]));
      pGetPropertiesAuxilar(Sender, ARecord, AProperties, LValor);
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.message, 'TProcessoOrdemServico.pGetProperties');
    End;
  End;
end;

procedure TProcessoOrdemServico.pGetPropertiesAuxilar(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties; strValor: String);
Begin
  case FComum.fGetStatus(strValor, TcxGridDBBandedColumn(Sender).DataBinding.FieldName) of
    stpRealizar,
    stpVisualizar,
    stpImprimir,
    stpNeutro: AProperties := cxEditRepositoryImageComboBoxItem.Properties;
  end;
end;

{ TProcessoComum }

constructor TProcessoComum.Create;
begin
  inherited;
   SetLength(FColumn, 0);
   SetLength(FDataFieldName, 0);

   FAtualizarGrid := True;

   FProcessando                := False;
   FComumAnterior              := nil;
   FComumSeguinte              := nil;
   FComumAntAnterior           := nil;
   FComumAntAnterior2          := nil;
   FChaveDireitoAcessoRealizar := '';
   FTitulo                     := '';
   FOnRealizar                 := nil;
   FOnVisualizar               := nil;
   FOnAposRealizar             := nil;
   FGetStatus                  := nil;
   FGetRealizadoDB             := nil;
   FPais                       := fSetaPais;
end;

destructor TProcessoComum.Destroy;
begin
  SetLength(FDataFieldName, 0);
  SetLength(FColumn, 0);
  inherited;
end;

function TProcessoComum.fColunaSoDisplay(AIndice: Integer): Boolean;
const
  LstrCampos: Array [0..17] of string = (TProcessoNumOS.DATA_FIELD_NAME_NUMEROOS,
    TProcessoDadosOS.DATA_FIELD_NAME_PROTOCOLO,
    TProcessoDadosOS.DATA_FIELD_NAME_EMP,
    TProcessoDadosOS.DATA_FIELD_NAME_DTINC,
    TProcessoDadosOS.DATA_FIELD_NAME_CLIENTE,
    TProcessoDadosOS.DATA_FIELD_NAME_CPFCNPJ,
    TProcessoDadosOS.DATA_FIELD_NAME_EQUIPAMENTO,
    TProcessoDadosOS.DATA_FIELD_NAME_MARCA,
    TProcessoDadosOS.DATA_FIELD_NAME_STATUS,
    TProcessoDadosOS.DATA_FIELD_NAME_SITUACAO,
    TProcessoDadosOS.DATA_FIELD_NAME_COMPLEMENTO,
    TProcessoDadosOS.DATA_FIELD_NAME_OBSERVACOES,
    TProcessoDadosOS.DATA_FIELD_NAME_MOTREPR,
    TProcessoGarantia.DATA_FIELD_NAME_TMPGAR,
    TProcessoFinalizacaoOS.DATA_FIELD_NAME_TMPFIN,
    TProcessoDadosOS.DATA_FIELD_NAME_NFREME,
    TProcessoDadosOS.DATA_FIELD_NAME_DTENTR_EQUIP,
    TProcessoTaxaArmazenamento.DATA_FIELD_NAME_TX_ARM);
begin
  Result := False;

  if (MatchStr(FCxgFluxoTBV.Columns[AIndice].DataBinding.FieldName, LstrCampos)) then
    Result := True;
end;

function TProcessoComum.fMensagemManutencao: String;
begin
  if (FComumAntAnterior.strTitulo = 'Reprovar') then
    Result := 'Para prosseguir, é necessário realizar a etapa anterior [Aprovar/Reprovar]'
  else
    Result := 'Para prosseguir, é necessário realizar a etapa anterior [' + FComumAntAnterior.strTitulo + ']';
end;

function TProcessoComum.fMensagemProsseguir: String;
begin
  Result := '';

  if (strTitulo = 'Reprovar') then
    Result := fMensagemReprovar
  else if (FComumAnterior.strTitulo = 'Apont. de Horas') then
  begin
    if (FComumAntAnterior.strTitulo = 'Manutenção') then
    begin
      if (FComumAntAnterior2.strTitulo = 'Reprovar') then
        Result := 'Para prosseguir, é necessário realizar a etapa anterior [Aprovar/Reprovar]'
      else
        Result := 'Para prosseguir, é necessário realizar a etapa anterior [' + FComumAntAnterior2.strTitulo + ']';
    end
    else if (FComumAntAnterior.strTitulo = 'Reprovar') then
      Result := 'Para prosseguir, é necessário realizar a etapa anterior [Aprovar/Reprovar]'
    else
      Result := 'Para prosseguir, é necessário realizar a etapa anterior [' + FComumAntAnterior.strTitulo + ']';
  end
  else if (FComumAnterior.strTitulo = 'Manutenção') then
    Result := fMensagemManutencao
  else if (FComumAnterior.strTitulo = 'Reprovar') then
    Result := 'Para prosseguir, é necessário realizar a etapa anterior [' + FComumAntAnterior.strTitulo + '/' + FComumAnterior.strTitulo + ']'
  else
    Result := 'Para prosseguir, é necessário realizar a etapa anterior [' + FComumAnterior.strTitulo + ']';
end;

function TProcessoComum.fMensagemReprovar: String;
begin
  if (FComumAnterior.strTitulo = 'Aprovar') then
    Result := 'Para prosseguir, é necessário realizar a etapa anterior [' + FComumAntAnterior.strTitulo + ']'
  else
    Result := 'Para prosseguir, é necessário realizar a etapa anterior [' + FComumAnterior.strTitulo + ']';
end;

function TProcessoComum.fVerificaColunaAnterior(ANumeroOS, ACodEmp: String): Boolean;
begin
  Result := False;

  if (FTipoProcesso = tprDadosOS) then
    Exit;

  if (FTipoProcesso = tprApontamento) then
    Exit;

  if not Assigned(FComumAnterior) then
    Exit;

  if FComumAnterior.FTipoProcesso in [tprNumOS, tprDadosOS] then
    Exit;

  if not fVerificaColunaReprovar(ANumeroOS, ACodEmp) then
    Exit;

  if not fVerificaColunaManutencao(ANumeroOS, ACodEmp) then
    Exit;

  if not fVerificaColunaApontamento(ANumeroOS, ACodEmp) then
    Exit;

  if FComumAnterior.FTipoProcesso <> tprApontamento then
    if (FComumAnterior.fGetRealizadoDB(ANumeroOS, ACodEmp)) then
      Exit;

  Result := True;
end;

function TProcessoComum.fVerificaColunaApontamento(ANumeroOS, ACodEmp: String): Boolean;
begin
   Result := False;

  if (FComumAnterior.FTipoProcesso = tprApontamento) then
  begin
    if (FTipoProcesso = tprArmazenar) then
    begin
      if FComumAntAnterior.FTipoProcesso <> tprManutencao then
      begin
        if (FComumAntAnterior.fGetRealizadoDB(ANumeroOS, ACodEmp)) then
          Exit;
      end
      else if Assigned(FComumAntAnterior2) then
        if (FComumAntAnterior2.fGetRealizadoDB(ANumeroOS, ACodEmp)) then
          Exit;
    end;
  end;

  Result := True;
end;

function TProcessoComum.fVerificaColunaManutencao(ANumeroOS,ACodEmp: String): Boolean;
begin
  Result := False;

  if (FComumAnterior.FTipoProcesso = tprManutencao) then
  begin
    if (FTipoProcesso = tprArmazenar) then
    begin
      if (FComumAntAnterior.fGetRealizadoDB(ANumeroOS, ACodEmp)) then
        Exit;
    end;
  end;

  Result := True;
end;

function TProcessoComum.fVerificaColunaReprovar(ANumeroOS, ACodEmp: String): Boolean;
begin
  Result := False;

  if (FTipoProcesso = tprReprovar) then
  begin
    if FComumAnterior.FTipoProcesso <> tprAprovar then
    begin
      if (FComumAnterior.fGetRealizadoDB(ANumeroOS, ACodEmp)) then
        Exit;
    end
    else
    begin
      if not Assigned(FComumAntAnterior) then
        Exit;

      if (FComumAntAnterior.fGetRealizadoDB(ANumeroOS, ACodEmp)) then
        Exit;
    end;
  end;

  Result := True;
end;

procedure TProcessoComum.pExecuta(AValor, ANumeroOS, ACodEmp, ANomeCampo: String);
begin
  if not Assigned(FGetStatus) then
    raise Exception.Create('FGetStatus não atribuído');

  case FGetStatus(AValor, ANomeCampo) of
    stpRealizar:   pRealizar(ANumeroOS, ACodEmp, ANomeCampo);
    stpVisualizar: pVisualizar(ANumeroOS, ACodEmp, ANomeCampo);
    stpImprimir :  pImprimir(ANumeroOS, ACodEmp, ANomeCampo);
  end;
end;

procedure TProcessoComum.pFormataCelula(ASender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  LstrValor : String;
  LvarValor : Variant;
begin
  if (not AViewInfo.GridRecord.IsData) then
    Exit;

  if (AViewInfo.GridRecord.Index >= 0) then
  begin
    if not Assigned(FGetStatus) then
      raise Exception.Create('FGetStatus não atribuído');

    LvarValor := ASender.ViewData.Records[AViewInfo.GridRecord.Index].Values[(AViewInfo.Item as TcxGridDBBandedColumn).Index];

    if VarIsNull(LvarValor) then
      LstrValor := ''
    else
      LstrValor := Trim(VarAsType( LvarValor, varString ));

    case FGetStatus(LstrValor, (AViewInfo.Item as TcxGridDBBandedColumn).DataBinding.FieldName) of
      stpRealizar   :  ACanvas.Font.Color := COR_REALIZAR;

      stpRealizado,
      stpVisualizar,
      stpImprimir   : ACanvas.Font.Color := COR_REALIZADO;
      stpNeutro     :
        begin
          ACanvas.Font.Color := COR_REALIZADO;
          ACanvas.Font.Style := [fsBold];
        end;
    end;

    if ((AViewInfo.Item as TcxGridDBBandedColumn).DataBinding.FieldName = 'CPFCNPJ') then
    begin
      ACanvas.FillRect(AViewInfo.Bounds);
      ACanvas.TextOut(AViewInfo.Bounds.Left + 2, AViewInfo.Bounds.Top + 2, fFormataCpfCgc(LvarValor, FPais));
      ADone := True;
    end;
  end;
end;

procedure TProcessoComum.pImprimir(ANumeroOS, ACodEmp, ANomeCampo : String);
begin
  if Assigned(FOnImprimir) then
  begin
    try
      FProcessando := True;
      FOnImprimir(ANumeroOS, ACodEmp, ANomeCampo);
    finally
      FProcessando := False;
    end;
  end;
end;

procedure TProcessoComum.pIncluiColuna(APosicao: Integer; AFieldName, ACaption, AClassName: String; AAlignmentHorz: TAlignment; AWidth: Integer);
begin
  stlDataFieldName[APosicao].strFieldName     := AFieldName;
  stlDataFieldName[APosicao].strCaption       := ACaption;
  stlDataFieldName[APosicao].strClassName     := AClassName;
  stlDataFieldName[APosicao].aliAlignmentHorz := AAlignmentHorz;
  stlDataFieldName[APosicao].intWidth         := AWidth;
end;

procedure TProcessoComum.pMouseMove(AGridSite: TcxGridSite; X, Y: Integer);
var
  LGridView: TcxGridDBBandedTableView;
  LHitTest: TcxCustomGridHitTest;
  LRecordIndex, LColumnIndex: Integer;
  LValue: Variant;
  LValor, LCampo : String;
begin
  if FProcessando then
    Exit;

  LGridView := AGridSite.GridView as TcxGridDBBandedTableView;
  LHitTest := LGridView.GetHitTest(X, Y);

  if (LHitTest is TcxGridRecordCellHitTest) then
  begin
    if not Assigned(FGetStatus) then
      raise Exception.Create('FGetStatus não atribuído');

    LRecordIndex := (LHitTest as TcxGridRecordCellHitTest).GridRecord.RecordIndex;
    LColumnIndex := (LHitTest as TcxGridRecordCellHitTest).Item.Index;
    LValue := AGridSite.GridView.DataController.Values[LRecordIndex, LColumnIndex];
    LCampo := LGridView.Columns[LColumnIndex].DataBinding.FieldName;

    if VarIsNull(LValue) then
      LValor := ''
    else
      LValor := Trim(VarAsType(LValue, varString ));

    if FGetStatus(LValor, LCampo) in [stpRealizar, stpVisualizar, stpImprimir] then
    begin
      pMouseMoveAuxiliar(LValor, AGridSite, X, Y, LRecordIndex, LColumnIndex, LGridView);
      Exit;
    end;
  end;

  AGridSite.Cursor := crDefault;
end;

procedure TProcessoComum.pMouseMoveAuxiliar(AValor: String; AGridSite: TcxGridSite; X, Y, ARecordIndex, AColumnIndex: Integer;
  AGridView: TcxGridDBBandedTableView);
begin
  If fColunaSoDisplay(AColumnIndex) Then
  Begin
    AGridSite.Cursor := crDefault;
    Exit;
  End;

  AGridSite.Cursor := crHandPoint;
end;

procedure TProcessoComum.pRealizar(ANumeroOS, ACodEmp, ANomeCampo : String);
begin
  if Assigned(FOnRealizar) then
  begin
    try
      FProcessando := True;

      if fVerificaColunaAnterior(ANumeroOS, ACodEmp) then
      begin
        if Assigned(FOnAposRealizar) then
          FOnAposRealizar();

        raise ExceptionMessage.Create(fMensagemProsseguir);
      end;

      FAtualizarGrid := True;

      FOnRealizar(ANumeroOS, ACodEmp, ANomeCampo);

      if not FAtualizarGrid then
        Exit;

      if not Assigned(FOnAposRealizar) then
        Exit;

      FOnAposRealizar();
    finally
      FProcessando := False;
    end;
  end;
end;

procedure TProcessoComum.pSetaNumeroColunas(ATamanho: Integer);
begin
  SetLength(FDataFieldName, ATamanho);
end;

procedure TProcessoComum.pVisualizar(ANumeroOS, ACodEmp, ANomeCampo : String);
begin
  if Assigned(FOnVisualizar) then
  begin
    try
      FProcessando := True;
      FOnVisualizar(ANumeroOS, ACodEmp, ANomeCampo);
    finally
      FProcessando := False;
    end;
  end;
end;

{ TProcessoDadosOS }

constructor TProcessoDadosOS.Create;
var
  intColumn: integer;
begin
  inherited;
  FComum.pSetaNumeroColunas(28);

  intColumn := 0;

  if (fCfgSis('PROSER', varBoolean))then
  begin
    FComum.pIncluiColuna(intColumn,  DATA_FIELD_NAME_PROTOCOLO,     'Protocolo',   'TcxTextEditProperties', taLeftJustify,  60);
    intColumn := intColumn + 1;
  end;

  FComum.pIncluiColuna(intColumn,  DATA_FIELD_NAME_CONSULTA,     'Consultar',   'TcxImageComboBoxProperties', taLeftJustify,  55);
  intColumn := intColumn + 1;

  FComum.pIncluiColuna(intColumn,  DATA_FIELD_NAME_EDITAR,       'Editar',   'TcxImageComboBoxProperties', taLeftJustify,  55);
  intColumn := intColumn + 1;

  pCriaColunasImpressao(intColumn);

  FComum.pIncluiColuna(intColumn,  DATA_FIELD_NAME_EMP,          'Emp',          'TcxTextEditProperties', taLeftJustify,  45);
  intColumn := intColumn + 1;
  FComum.pIncluiColuna(intColumn,  DATA_FIELD_NAME_DTINC,        'Dt. Inc.',     'TcxTextEditProperties', taLeftJustify,  60);
  intColumn := intColumn + 1;

  FComum.pIncluiColuna(intColumn,  DATA_FIELD_NAME_CLIENTE,      'Cliente',      'TcxTextEditProperties', taLeftJustify, 300);
  intColumn := intColumn + 1;

  FComum.pIncluiColuna(intColumn,  DATA_FIELD_NAME_CPFCNPJ,      'CPF/CNPJ Cliente', 'TcxTextEditProperties', taLeftJustify, 120);
  intColumn := intColumn + 1;

  FComum.pIncluiColuna(intColumn,  DATA_FIELD_NAME_EQUIPAMENTO,  'Equipamento',  'TcxTextEditProperties', taLeftJustify, 200);
  intColumn := intColumn + 1;
  FComum.pIncluiColuna(intColumn,  DATA_FIELD_NAME_MARCA,        'Marca',        'TcxTextEditProperties', taLeftJustify, 200);
  intColumn := intColumn + 1;
  FComum.pIncluiColuna(intColumn,  DATA_FIELD_NAME_STATUS,       'Fase',         'TcxTextEditProperties', taLeftJustify, 130);
  intColumn := intColumn + 1;
  FComum.pIncluiColuna(intColumn, DATA_FIELD_NAME_SITUACAO,      'Situação',     'TcxTextEditProperties', taLeftJustify, 150);
  intColumn := intColumn + 1;
  FComum.pIncluiColuna(intColumn, DATA_FIELD_NAME_COMPLEMENTO,   'Complemento',  'TcxTextEditProperties', taLeftJustify, 160);
  intColumn := intColumn + 1;

  if (fCfgSis('FXEOBS', varBoolean))then
  begin
    FComum.pIncluiColuna(intColumn, DATA_FIELD_NAME_OBSERVACOES,   'Observações',  'TcxMemoEditProperties', taLeftJustify, 250);
    intColumn := intColumn + 1;
  end;

  FComum.pIncluiColuna(intColumn,  DATA_FIELD_NAME_MOTREPR,      'Mot. Reprovação',      'TcxTextEditProperties', taLeftJustify, 100);
  intColumn := intColumn + 1;

  FComum.pIncluiColuna(intColumn, DATA_FIELD_NAME_HISTSTATUS,    'Hist. Status'     , 'TcxImageComboBoxProperties',    taCenter,       60);
  intColumn := intColumn + 1;
  FComum.pIncluiColuna(intColumn, DATA_FIELD_NAME_HISTETAPAS,    'Hist. Etapas'     , 'TcxImageComboBoxProperties',    taCenter,       60);
  intColumn := intColumn + 1;
  FComum.pIncluiColuna(intColumn, DATA_FIELD_NAME_HISTFAT   ,    'Hist. Faturamento', 'TcxImageComboBoxProperties',    taCenter,       60);

  intColumn := intColumn + 1;
  FComum.pIncluiColuna(intColumn,  DATA_FIELD_NAME_NFREME,        'NF Remessa',        'TcxTextEditProperties', taLeftJustify, 80);

  intColumn := intColumn + 1;
  FComum.pIncluiColuna(intColumn,  DATA_FIELD_NAME_DTENTR_EQUIP,        'Dt. Entrega Equip.',        'TcxTextEditProperties', taLeftJustify, 60);

  intColumn := intColumn + 1;
  FComum.pIncluiColuna(intColumn,  DATA_FIELD_NAME_DIG_ENTREG,        'Digitador Entrega do Equip',        'TcxTextEditProperties', taLeftJustify, 100);

  intColumn := intColumn + 1;
  FComum.pIncluiColuna(intColumn,  DATA_FIELD_NAME_DTFIN_MAN ,        'Dt. Finalização Man.',        'TcxTextEditProperties', taLeftJustify, 60);

  intColumn := intColumn + 1;
  FComum.pIncluiColuna(intColumn,  DATA_FIELD_NAME_CON_PAGTO ,        'Cond. Pagto',        'TcxTextEditProperties', taLeftJustify, 60);

  intColumn := intColumn + 1;
  FComum.pIncluiColuna(intColumn,  DATA_FIELD_NAME_FOR_PAGTO ,        'Forma Pagto',        'TcxTextEditProperties', taLeftJustify, 60);

  FComum.pSetaNumeroColunas(intColumn + 1);

  FComum.tprTipoProcesso := tprDadosOS;
  FComum.strTitulo       := TITULO;
  FComum.OnVisualizar    := Self.pOnVisualizar;
  FComum.OnImprimir      := Self.pOnImprimir;
  FComum.GetStatus       := Self.fGetStatus;
end;

function TProcessoDadosOS.fGetStatus(AValor: String; ANomeCampo: String = ''): TStatusProcesso;
begin
  Result := stpRealizado;

  if fEmptyStr(AValor) then
    Exit;

  case AnsiIndexStr(UpperCase(ANomeCampo), [DATA_FIELD_NAME_CONSULTA, DATA_FIELD_NAME_IMP, DATA_FIELD_NAME_ETI,
    DATA_FIELD_NAME_TDEV, DATA_FIELD_NAME_HISTSTATUS, DATA_FIELD_NAME_EDITAR, DATA_FIELD_NAME_TRESP, DATA_FIELD_NAME_ORDEXE,
    DATA_FIELD_NAME_HISTETAPAS, DATA_FIELD_NAME_HISTFAT]) of
    1, 2, 3, 6, 7: Result := stpImprimir;
    0, 4, 5, 8, 9: Result := stpVisualizar;
  end;
end;

function TProcessoDadosOS.getProcessoComum: TProcessoComum;
begin
  Result := FComum;
end;

procedure TProcessoDadosOS.pCriaColunasImpressao(var intColumn: integer);
begin
  FComum.pIncluiColuna(intColumn,  DATA_FIELD_NAME_IMP,          'Imp',          'TcxImageComboBoxProperties',    taCenter,       45);
  intColumn := intColumn + 1;

  FComum.pIncluiColuna(intColumn,  DATA_FIELD_NAME_ETI,          'Eti',          'TcxImageComboBoxProperties',    taCenter,       45);
  intColumn := intColumn + 1;

  if (fCfgSis('TERCEQ', varBoolean)) then
  begin
    FComum.pIncluiColuna(intColumn,  DATA_FIELD_NAME_TRESP,        'T.Resp',       'TcxImageComboBoxProperties',    taCenter,       45);
    intColumn := intColumn + 1;
  end;

  FComum.pIncluiColuna(intColumn,  DATA_FIELD_NAME_TDEV,         'T.Dev',        'TcxImageComboBoxProperties',    taCenter,       45);
  intColumn := intColumn + 1;

  if fCfgSis('OSIMOE', varBoolean) then
  begin
    FComum.pIncluiColuna(intColumn,  DATA_FIELD_NAME_ORDEXE,       'Ord.Exe',        'TcxImageComboBoxProperties',    taCenter,       45);
    intColumn := intColumn + 1;
  end;
end;

procedure TProcessoDadosOS.pOnImprimir(ANumeroOS, ACodEmp, ANomeCampo: String);
var
  frmFatManConsertoEquip: TfrmFatManConsertoEquip;
begin
  pCriarFormularios(TfrmFatManConsertoEquip, frmFatManConsertoEquip);

  try
    frmFatManConsertoEquip.blnFluxoProcesso := True;
    frmFatManConsertoEquip.edtNumero.Text   := ANumeroOS;
    frmFatManConsertoEquip.edtCodEmp.Text   := ACodEmp;
    frmFatManConsertoEquip.tpProcessoFlx    := tprDadosOS;

    if ANomeCampo = DATA_FIELD_NAME_CONSULTA then
      frmFatManConsertoEquip.tpImpressaoFlx := fpConsultar
    else if ANomeCampo = DATA_FIELD_NAME_IMP then
      frmFatManConsertoEquip.tpImpressaoFlx := fpImprimir
    else if ANomeCampo = DATA_FIELD_NAME_ETI then
      frmFatManConsertoEquip.tpImpressaoFlx := fpEtiqueta
    else if ANomeCampo = DATA_FIELD_NAME_TRESP then
      frmFatManConsertoEquip.tpImpressaoFlx := fpTermoResp
    else if ANomeCampo = DATA_FIELD_NAME_TDEV then
      frmFatManConsertoEquip.tpImpressaoFlx := fpTermoDev
    else if ANomeCampo = DATA_FIELD_NAME_ORDEXE then
      frmFatManConsertoEquip.tpImpressaoFlx := fpOrdExecucao;

    frmFatManConsertoEquip.ShowModal();
  finally
    pFreeAndNil(frmFatManConsertoEquip);
  end;
end;

procedure TProcessoDadosOS.pOnVisualizar(ANumeroOS, ACodEmp, ANomeCampo: String);
var
  frmFatManConsertoEquip: TfrmFatManConsertoEquip;
begin
  if (ANomeCampo = 'HIST_STATUS') then
    pVisualizarHistStatus(ANumeroOS, ACodEmp)
  else if (ANomeCampo = 'HIST_ETAPAS') then
    pVisualizarHistEtapas(ANumeroOS, ACodEmp)
  else if (ANomeCampo = 'HIST_FAT') then
    pVisualizarHistFaturamento(ANumeroOS, ACodEmp)
  else
  begin
    pCriarFormularios(TfrmFatManConsertoEquip, frmFatManConsertoEquip);

    try
      frmFatManConsertoEquip.blnFluxoProcesso              := True;
      frmFatManConsertoEquip.tpProcessoFlx                 := tprDadosOS;
      frmFatManConsertoEquip.edtNumero.Text                := ANumeroOS;
      frmFatManConsertoEquip.edtCodEmp.Text                := ACodEmp;
      frmFatManConsertoEquip.btnRealizada.Visible          := False;
      frmFatManConsertoEquip.btnImprimir.Visible           := False;
      frmFatManConsertoEquip.btnTermoDev.Visible           := False;
      frmFatManConsertoEquip.btnAlteracao.Visible          := False;
      frmFatManConsertoEquip.btnEndEnt.Visible             := False;
      frmFatManConsertoEquip.btnDesEsp.Visible             := False;
      frmFatManConsertoEquip.btnReprovar.Visible           := False;
      frmFatManConsertoEquip.btnAprovada.Visible           := False;
      frmFatManConsertoEquip.btnCancelar.Visible           := False;
      frmFatManConsertoEquip.btnManutencao.Visible         := False;
      frmFatManConsertoEquip.btnHisSta.Visible             := False;
      frmFatManConsertoEquip.btnSalRes.Visible             := False;
      frmFatManConsertoEquip.btnImpostos.Visible           := False;
      frmFatManConsertoEquip.btnAddObsTec.Visible          := (ANomeCampo = 'CONSULTA_OS');
      frmFatManConsertoEquip.btnImpEti.Visible             := False;
      frmFatManConsertoEquip.btnReativar.Visible           := False;
      frmFatManConsertoEquip.btnUltimasVendas.Visible      := False;
      frmFatManConsertoEquip.btnComunicacaoInterna.Visible := True;
      frmFatManConsertoEquip.edtNumero.Enabled             := False;
      frmFatManConsertoEquip.btnImpSeparacao.Visible       := False;
      frmFatManConsertoEquip.btnConfirmar.Visible          := False;
      frmFatManConsertoEquip.btnApontHoras.Visible         := False;
      frmFatManConsertoEquip.btnImpPed.Visible             := False;
      frmFatManConsertoEquip.btnPedCompraItens.Visible     := False;
      frmFatManConsertoEquip.btnOrdMaoObrCli.Visible       := (ANomeCampo <> 'EDITAR_OS');
      frmFatManConsertoEquip.btnConsultaCatalogos.Visible  := False;
      frmFatManConsertoEquip.btnDevCli.Visible             := False;
      frmFatManConsertoEquip.btnCancelarOS.Visible         := False;
      frmFatManConsertoEquip.gbDadGerOS.Enabled            := False;
      frmFatManConsertoEquip.gbDadEqu.Enabled              := True;
      frmFatManConsertoEquip.grbDocEntrada.Enabled         := True;
      frmFatManConsertoEquip.grbDocSaida.Enabled           := (FCxgFluxoTBV.DataController.DataSet.FieldByName('EQU_FLXSIT').AsString = 'AF') or
        (FCxgFluxoTBV.DataController.DataSet.FieldByName('EQU_FLXCOM').AsString = 'AF');

      if (FCxgFluxoTBV.GetColumnByFieldName(DATA_FIELD_NAME_STATUS).DataBinding.Field.Value = 'OS CANCELADA') then
      begin
        frmFatManConsertoEquip.blnOSCancelada                := True;
        frmFatManConsertoEquip.btnImpItensServicos.Visible   := False;
      end;

      if (ANomeCampo = 'CONSULTA_OS') then
        frmFatManConsertoEquip.tpImpressaoFlx                := fpConsultar
      else if (ANomeCampo = 'EDITAR_OS') then
      begin
        frmFatManConsertoEquip.tpImpressaoFlx                := fpEditar;
        frmFatManConsertoEquip.gbDadGerOS.Enabled            := True;
        frmFatManConsertoEquip.btnObservacao.Visible         := False;
      end;

      frmFatManConsertoEquip.btnAlteraItens.Visible          := False;
      frmFatManConsertoEquip.btnBrindeTotalServ.Visible      := False;

      frmFatManConsertoEquip.ShowModal();
    finally
      pFreeAndNil(frmFatManConsertoEquip);
    end;
  end;
end;

procedure TProcessoDadosOS.pVisualizarHistEtapas(ANumeroOS, ACodEmp: String);
begin
  if Assigned(prcExecutaRelatorio) then
  begin
    prcExecutaRelatorio(347, 15170, [],
                        ['USADIG','NUMOSE','CODEMP'],
                        [IfThen(fCfgSis('USADIG', varBoolean),'S','N'),
                        ANumeroOS,
                        ACodEmp],
                        nil,
                        nil,
                        True);
  end;
end;

procedure TProcessoDadosOS.pVisualizarHistFaturamento(ANumeroOS, ACodEmp: String);
begin
  if Assigned(prcExecutaRelatorio) then
  begin
    prcExecutaRelatorio(348, 15174, [],
                        ['NUMOSE','CODEMP'],
                        [ANumeroOS,
                        ACodEmp],
                        nil,
                        nil,
                        True);
  end;
end;

procedure TProcessoDadosOS.pVisualizarHistStatus(ANumeroOS, ACodEmp: String);
begin
  if Assigned(prcExecutaRelatorio) then
  begin
    prcExecutaRelatorio(181, 7446, [],
                        ['USADIG','NUMOSE','CODEMP'],
                        [IfThen(fCfgSis('USADIG', varBoolean),'S','N'),
                        ANumeroOS,
                        ACodEmp],
                        nil,
                        nil,
                        True);
  end;
end;

{ TProcessoDocsFiscais }

constructor TProcessoDocsFiscais.Create;
begin
  inherited;
  FComum.pSetaNumeroColunas(2);
  FComum.pIncluiColuna(0, DATA_FIELD_NAME_ENT, 'Entrada de NF', 'TcxTextEditProperties', taCenter, 90);
  FComum.pIncluiColuna(1, DATA_FIELD_NAME_SAI, 'NF de Saída',   'TcxTextEditProperties', taCenter, 90);
  FComum.tprTipoProcesso := tprDocsFiscais;
  FComum.strTitulo       := TITULO;
  FComum.GetStatus       := Self.fGetStatus;
  FComum.GetRealizadoDB  := Self.fGetRealizadoDB;
end;

function TProcessoDocsFiscais.fGetRealizadoDB(ANumeroOS, ACodEmp: String): Boolean;
begin
  Result := True;
end;

function TProcessoDocsFiscais.fGetStatus(AValor: String; ANomeCampo: String = ''): TStatusProcesso;
begin
  if (AValor = 'REALIZAR') then
    Result := stpRealizar
  else
    Result := stpRealizado;
end;

function TProcessoDocsFiscais.getProcessoComum: TProcessoComum;
begin
  Result := FComum;
end;

{ TProcessoDefPrdSer }

constructor TProcessoDefPrdSer.Create;
begin
  inherited;
  FComum.pSetaNumeroColunas(1);
  FComum.pIncluiColuna(0, DATA_FIELD_NAME, 'Status', 'TcxTextEditProperties', taCenter, 140);
  FComum.tprTipoProcesso := tprDefPrdSer;
  FComum.strTitulo       := TITULO;
  FComum.GetStatus       := Self.fGetStatus;
  FComum.GetRealizadoDB  := Self.fGetRealizadoDB;
end;

function TProcessoDefPrdSer.fGetRealizadoDB(ANumeroOS, ACodEmp: String): Boolean;
var
  qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery(nil);
  try
    { CONSULTA SERVIÇOS }
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT IF(EQU_STATUS <> "E", 1, ');
    qryConsulta.SQL.Add('(SELECT COUNT(1) FROM EQUSER ');
    qryConsulta.SQL.Add(' WHERE EQUSER.EQU_NUMOSE = EQUGER.EQU_NUMOSE ');
    qryConsulta.SQL.Add('     AND EQUSER.EQU_CODEMP = EQUGER.EQU_CODEMP)) QTDE ');
    qryConsulta.SQL.Add('FROM EQUGER ');
    qryConsulta.SQL.Add('WHERE EQU_NUMOSE = :NUMOSE ');
    qryConsulta.SQL.Add('    AND EQU_CODEMP = :CODEMP');
    qryConsulta.ParamByName('NUMOSE').AsString := ANumeroOS;
    qryConsulta.ParamByName('CODEMP').AsString := ACodEmp;
    qryConsulta.Open;

    Result := qryConsulta.FieldByName('QTDE').AsFloat > 0;

    qryConsulta.Close;

    if not Result then
    begin
      { CONSULTA ITENS }
      qryConsulta.SQL.Clear;
      qryConsulta.SQL.Add('SELECT IF(EQU_STATUS <> "E", 1, ');
      qryConsulta.SQL.Add('(SELECT COUNT(1) FROM EQUDET ');
      qryConsulta.SQL.Add(' WHERE EQUDET.EQU_NUMOSE = EQUGER.EQU_NUMOSE ');
      qryConsulta.SQL.Add('     AND EQUDET.EQU_CODEMP = EQUGER.EQU_CODEMP)) QTDE ');
      qryConsulta.SQL.Add('FROM EQUGER ');
      qryConsulta.SQL.Add('WHERE EQU_NUMOSE = :NUMOSE ');
      qryConsulta.SQL.Add('    AND EQU_CODEMP = :CODEMP');
      qryConsulta.ParamByName('NUMOSE').AsString := ANumeroOS;
      qryConsulta.ParamByName('CODEMP').AsString := ACodEmp;
      qryConsulta.Open;

      Result := qryConsulta.FieldByName('QTDE').AsFloat > 0;

      qryConsulta.Close;
    end;
  finally
    pFreeAndNil(qryConsulta);
  end;
end;

function TProcessoDefPrdSer.fGetStatus(AValor: String; ANomeCampo: String = ''): TStatusProcesso;
begin
  if (AValor = 'INCLUIR / REMOVER') then
    Result := stpRealizar
  else
    Result := stpRealizado;
end;

function TProcessoDefPrdSer.getProcessoComum: TProcessoComum;
begin
  Result := FComum;
end;

{ TProcessoOrcamento }

constructor TProcessoOrcamento.Create;
begin
  inherited;
  FComum.pSetaNumeroColunas(1);
  FComum.pIncluiColuna(0, DATA_FIELD_NAME, 'Status', 'TcxTextEditProperties', taCenter, 100);
  FComum.tprTipoProcesso := tprOrcamento;
  FComum.strTitulo       := TITULO;
  FComum.GetStatus       := Self.fGetStatus;
  FComum.GetRealizadoDB  := Self.fGetRealizadoDB;
end;

function TProcessoOrcamento.fGetRealizadoDB(ANumeroOS, ACodEmp: String): Boolean;
var
  qryOrcamento: TUniQuery;
begin
  qryOrcamento := fCriaQuery(nil);
  try
    qryOrcamento.SQL.Add('SELECT EQU_STATUS ');
    qryOrcamento.SQL.Add('FROM EQUGER ');
    qryOrcamento.SQL.Add('WHERE EQU_NUMOSE = :NUMOSE ');
    qryOrcamento.SQL.Add('    AND EQU_CODEMP = :CODEMP');
    qryOrcamento.ParamByName('NUMOSE').AsString := ANumeroOS;
    qryOrcamento.ParamByName('CODEMP').AsString := ACodEmp;
    qryOrcamento.Open;

    Result := qryOrcamento.FieldByName('EQU_STATUS').AsString <> 'E';

    qryOrcamento.Close;
  finally
    pFreeAndNil(qryOrcamento);
  end;
end;

function TProcessoOrcamento.fGetStatus(AValor: String; ANomeCampo: String = ''): TStatusProcesso;
begin
  if (AValor = 'REALIZAR') then
    Result := stpRealizar
  else
    Result := stpRealizado;
end;

function TProcessoOrcamento.getProcessoComum: TProcessoComum;
begin
  Result := FComum;
end;

{ TProcessoAprovar }

constructor TProcessoAprovar.Create;
begin
  inherited;
  FComum.pSetaNumeroColunas(1);
  FComum.pIncluiColuna(0, DATA_FIELD_NAME, 'Status', 'TcxTextEditProperties', taCenter, 100);
  FComum.tprTipoProcesso := tprAprovar;
  FComum.strTitulo       := TITULO;
  FComum.GetStatus       := Self.fGetStatus;
  FComum.GetRealizadoDB  := Self.fGetRealizadoDB;
end;

function TProcessoAprovar.fGetRealizadoDB(ANumeroOS, ACodEmp: String): Boolean;
var
  qryAprovar: TUniQuery;
begin
  Result := False;

  qryAprovar := fCriaQuery(nil);
  try
    qryAprovar.SQL.Add('SELECT EQU_STATUS ');
    qryAprovar.SQL.Add('FROM EQUGER ');
    qryAprovar.SQL.Add('WHERE EQU_NUMOSE = :NUMOSE ');
    qryAprovar.SQL.Add('    AND EQU_CODEMP = :CODEMP');
    qryAprovar.ParamByName('NUMOSE').AsString := ANumeroOS;
    qryAprovar.ParamByName('CODEMP').AsString := ACodEmp;
    qryAprovar.Open;

    if (qryAprovar.FieldByName('EQU_STATUS').AsString = 'E') then
      Exit;

    if (qryAprovar.FieldByName('EQU_STATUS').AsString = 'F') then
      Exit;

    Result := True;

    qryAprovar.Close;
  finally
    pFreeAndNil(qryAprovar);
  end;
end;

function TProcessoAprovar.fGetStatus(AValor: String; ANomeCampo: String = ''): TStatusProcesso;
begin
  if (AValor = 'APROVAR') then
    Result := stpRealizar
  else
    Result := stpRealizado;
end;

function TProcessoAprovar.getProcessoComum: TProcessoComum;
begin
  Result := FComum;
end;

{ TProcessoReprovar }

constructor TProcessoReprovar.Create;
begin
  inherited;
  FComum.pSetaNumeroColunas(1);
  FComum.pIncluiColuna(0, DATA_FIELD_NAME, 'Status', 'TcxTextEditProperties', taCenter, 100);
  FComum.tprTipoProcesso := tprReprovar;
  FComum.strTitulo       := TITULO;
  FComum.GetStatus       := Self.fGetStatus;
  FComum.GetRealizadoDB  := Self.fGetRealizadoDB;
end;

function TProcessoReprovar.fGetRealizadoDB(ANumeroOS, ACodEmp: String): Boolean;
var
  qryAprovar: TUniQuery;
begin
  Result := False;

  qryAprovar := fCriaQuery(nil);
  try
    qryAprovar.SQL.Add('SELECT EQU_STATUS ');
    qryAprovar.SQL.Add('FROM EQUGER ');
    qryAprovar.SQL.Add('WHERE EQU_NUMOSE = :NUMOSE ');
    qryAprovar.SQL.Add('    AND EQU_CODEMP = :CODEMP');
    qryAprovar.ParamByName('NUMOSE').AsString := ANumeroOS;
    qryAprovar.ParamByName('CODEMP').AsString := ACodEmp;
    qryAprovar.Open;

    if (qryAprovar.FieldByName('EQU_STATUS').AsString = 'E') then
      Exit;

    if (qryAprovar.FieldByName('EQU_STATUS').AsString = 'F') then
      Exit;

    Result := True;

    qryAprovar.Close;
  finally
    pFreeAndNil(qryAprovar);
  end;
end;

function TProcessoReprovar.fGetStatus(AValor: String; ANomeCampo: String = ''): TStatusProcesso;
begin
  if (AValor = 'REPROVAR') then
    Result := stpRealizar
  else
    Result := stpRealizado;
end;

function TProcessoReprovar.getProcessoComum: TProcessoComum;
begin
  Result := FComum;
end;

{ TProcessoManutencao }

constructor TProcessoManutencao.Create;
begin
  inherited;
  FComum.pSetaNumeroColunas(1);
  FComum.pIncluiColuna(0, DATA_FIELD_NAME, 'Status', 'TcxTextEditProperties', taCenter, 100);
  FComum.tprTipoProcesso := tprManutencao;
  FComum.strTitulo       := TITULO;
  FComum.GetStatus       := Self.fGetStatus;
  FComum.GetRealizadoDB  := Self.fGetRealizadoDB;
end;

function TProcessoManutencao.fGetRealizadoDB(ANumeroOS, ACodEmp: String): Boolean;
begin
  Result := True;
end;

function TProcessoManutencao.fGetStatus(AValor: String; ANomeCampo: String = ''): TStatusProcesso;
begin
  if (AValor = 'REALIZAR') then
    Result := stpRealizar
  else
    Result := stpRealizado;
end;

function TProcessoManutencao.getProcessoComum: TProcessoComum;
begin
  Result := FComum;
end;

{ TProcessoFinalizar }

constructor TProcessoFinalizar.Create;
begin
  inherited;
  FComum.pSetaNumeroColunas(1);
  FComum.pIncluiColuna(0, DATA_FIELD_NAME, 'Status', 'TcxTextEditProperties', taCenter, 100);
  FComum.tprTipoProcesso := tprArmazenar;
  FComum.strTitulo       := TITULO;
  FComum.GetStatus       := Self.fGetStatus;
  FComum.GetRealizadoDB  := Self.fGetRealizadoDB;
end;

function TProcessoFinalizar.fGetRealizadoDB(ANumeroOS, ACodEmp: String): Boolean;
var
  qryFinalizar: TUniQuery;
begin
  Result := True;

  qryFinalizar := fCriaQuery(nil);
  try
    qryFinalizar.SQL.Add('SELECT EQU_STATUS ');
    qryFinalizar.SQL.Add('FROM EQUGER ');
    qryFinalizar.SQL.Add('WHERE EQU_NUMOSE = :NUMOSE ');
    qryFinalizar.SQL.Add('    AND EQU_CODEMP = :CODEMP');
    qryFinalizar.ParamByName('NUMOSE').AsString := ANumeroOS;
    qryFinalizar.ParamByName('CODEMP').AsString := ACodEmp;
    qryFinalizar.Open;

    if (qryFinalizar.FieldByName('EQU_STATUS').AsString = 'R') then
      Exit;

    if (qryFinalizar.FieldByName('EQU_STATUS').AsString = 'N') then
      Exit;

    Result := False;

    qryFinalizar.Close;
  finally
    pFreeAndNil(qryFinalizar);
  end;
end;

function TProcessoFinalizar.fGetStatus(AValor: String; ANomeCampo: String = ''): TStatusProcesso;
begin
  if (AValor = 'REALIZAR') then
    Result := stpRealizar
  else
    Result := stpRealizado;
end;

function TProcessoFinalizar.getProcessoComum: TProcessoComum;
begin
  Result := FComum;
end;

{ TProcessoRetirar }

constructor TProcessoRetirar.Create;
begin
  inherited;
  FComum.pSetaNumeroColunas(1);
  FComum.pIncluiColuna(0, DATA_FIELD_NAME, 'Status', 'TcxTextEditProperties', taCenter, 100);
  FComum.tprTipoProcesso := tprRetirar;
  FComum.strTitulo       := TITULO;
  FComum.GetStatus       := Self.fGetStatus;
end;

function TProcessoRetirar.fGetStatus(AValor: String; ANomeCampo: String = ''): TStatusProcesso;
begin
  if (AValor = 'REALIZAR') then
    Result := stpRealizar
  else
    Result := stpRealizado;
end;

function TProcessoRetirar.getProcessoComum: TProcessoComum;
begin
  Result := FComum;
end;

{ TProcessoNumOS }

constructor TProcessoNumOS.Create;
begin
  inherited;
  FComum.pSetaNumeroColunas(2);
  FComum.pIncluiColuna(0,  DATA_FIELD_NAME_STATUSOS, 'Status', 'TcxImageComboBoxProperties', taLeftJustify, 45);
  FComum.pIncluiColuna(1,  DATA_FIELD_NAME_NUMEROOS, 'O.S.',   'TcxTextEditProperties',   taLeftJustify, 55);
  FComum.tprTipoProcesso := tprNumOS;
  FComum.strTitulo       := TITULO;
  FComum.GetStatus       := Self.fGetStatus;
end;

function TProcessoNumOS.fGetStatus(AValor, ANomeCampo: String): TStatusProcesso;
begin
  if (AValor = 'S') then
    Result := stpNeutro
  else
    Result := stpRealizado;
end;

function TProcessoNumOS.getProcessoComum: TProcessoComum;
begin
  Result := FComum;
end;

{ TProcessoApontamento }

constructor TProcessoApontamento.Create;
begin
  inherited;
  FComum.pSetaNumeroColunas(1);
  FComum.pIncluiColuna(0, DATA_FIELD_NAME, 'Status', 'TcxTextEditProperties', taCenter, 100);
  FComum.tprTipoProcesso := tprApontamento;
  FComum.strTitulo       := TITULO;
  FComum.GetStatus       := Self.fGetStatus;
  FComum.GetRealizadoDB  := Self.fGetRealizadoDB;
end;

function TProcessoApontamento.fGetRealizadoDB(ANumeroOS, ACodEmp: String): Boolean;
begin
  Result := True;
end;

function TProcessoApontamento.fGetStatus(AValor, ANomeCampo: String): TStatusProcesso;
begin
  if AValor = 'INCLUIR' then
    Result := stpRealizar
  else
    Result := stpRealizado;
end;

function TProcessoApontamento.getProcessoComum: TProcessoComum;
begin
  Result := FComum;
end;

{ TProcessoGarantia }

constructor TProcessoGarantia.Create;
var
  intColumn: integer;
begin
  inherited;
  intColumn := 0;
  FComum.pSetaNumeroColunas(3);

  if (fVerificaAcessoSistema('FXOSFA', strLoginUsuarioLogado)) then
  begin
    FComum.pIncluiColuna(intColumn, DATA_FIELD_NAME_NOSFAB, 'OS Fabricante', 'TcxTextEditProperties', taCenter, 70);
    intColumn := intColumn + 1;
  end;

  if (fCfgSis('EFXTPG', varBoolean)) then
  begin
    FComum.pIncluiColuna(intColumn, DATA_FIELD_NAME_STAGAR, 'Status Garantia', 'TcxImageComboBoxProperties', taCenter, 55);
    intColumn := intColumn + 1;
    FComum.pIncluiColuna(intColumn, DATA_FIELD_NAME_TMPGAR, 'Tempo Restante Garantia', 'TcxTextEditProperties', taCenter, 55);
    intColumn := intColumn + 1;
  end;

  FComum.pSetaNumeroColunas(intColumn);
  FComum.tprTipoProcesso := tprGarantia;
  FComum.strTitulo       := TITULO;
  FComum.GetStatus       := Self.fGetStatus;
end;

function TProcessoGarantia.fGetStatus(AValor, ANomeCampo: String): TStatusProcesso;
begin
  if (ANomeCampo = 'STATUS_GA') then
    Result := stpNeutro
  else
    Result := stpRealizado;
end;

function TProcessoGarantia.getProcessoComum: TProcessoComum;
begin
  Result := FComum;
end;

{ TProcessoFinalizacaoOS }

constructor TProcessoFinalizacaoOS.Create;
begin
  inherited;
  FComum.pSetaNumeroColunas(2);

  FComum.pIncluiColuna(0, DATA_FIELD_NAME_STAFIN, 'Status Finalização',         'TcxImageComboBoxProperties', taCenter, 65);
  FComum.pIncluiColuna(1, DATA_FIELD_NAME_TMPFIN, 'Tempo Restante Finalização', 'TcxTextEditProperties',      taCenter, 65);

  FComum.tprTipoProcesso := tprFinalizacaoOS;
  FComum.strTitulo       := TITULO;
  FComum.GetStatus       := Self.fGetStatus;
end;

function TProcessoFinalizacaoOS.fGetStatus(AValor, ANomeCampo: String): TStatusProcesso;
begin
  if (ANomeCampo = 'STATUS_GA') then
    Result := stpNeutro
  else
    Result := stpRealizado;
end;

function TProcessoFinalizacaoOS.getProcessoComum: TProcessoComum;
begin
  Result := FComum;
end;

{ TProcessoTaxaArmazenamento }

constructor TProcessoTaxaArmazenamento.Create;
begin
  inherited;
  FComum.pSetaNumeroColunas(1);

  FComum.pIncluiColuna(0, DATA_FIELD_NAME_TX_ARM, 'Total Taxa', 'TcxTextEditProperties', taRightJustify, 80);

  FComum.tprTipoProcesso := tprTaxaArmazenamento;
  FComum.strTitulo       := TITULO;
  FComum.GetStatus       := Self.fGetStatus;
end;

function TProcessoTaxaArmazenamento.fGetStatus(AValor,
  ANomeCampo: String): TStatusProcesso;
begin
  Result := stpRealizado;
end;

function TProcessoTaxaArmazenamento.getProcessoComum: TProcessoComum;
begin
  Result := FComum;
end;

end.