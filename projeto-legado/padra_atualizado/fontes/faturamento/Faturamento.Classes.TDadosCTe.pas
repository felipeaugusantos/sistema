unit Faturamento.Classes.TDadosCTe;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core, untFuncoesGenerica,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  Uni, System.SysUtils, Data.DB, StrUtils, untConstantes;

type
  TPartilhaCTe = class(TObject)
  private
    FValorBaseCalculoIcmsUfDestino: Double;
    FAliquotaIcmsInternaUfDestino: Double;
    FAliquotaIcmsInterestadual: Double;
    FValorIcmsPartilhaTermino: Double;
    FValorIcmsPartilhaInicio: Double;
    FAliquotaFcp: Double;
    FValorFcpDestino: Double;
    FGrava: Boolean;

    procedure pObterAliquotaInterestadual(strUFEndEntrega: string);
  public
    constructor Create();
    procedure Assign(AOrigem: TPartilhaCTe);

    procedure pLimpaDadosObjeto;
    procedure pAlimentarPadraoAliquotas(const fltAliqIcmsInternaUfDestino: Double; const blnDentroEstado: Boolean; const strUFEntrega: string);

    property fltValorBaseCalculoIcmsUfDestino : Double  read FValorBaseCalculoIcmsUfDestino write FValorBaseCalculoIcmsUfDestino;
    property fltAliquotaIcmsInternaUfDestino  : Double  read FAliquotaIcmsInternaUfDestino  write FAliquotaIcmsInternaUfDestino ;
    property fltAliquotaIcmsInterestadual     : Double  read FAliquotaIcmsInterestadual     write FAliquotaIcmsInterestadual    ;
    property fltValorIcmsPartilhaTermino      : Double  read FValorIcmsPartilhaTermino      write FValorIcmsPartilhaTermino     ;
    property fltValorIcmsPartilhaInicio       : Double  read FValorIcmsPartilhaInicio       write FValorIcmsPartilhaInicio      ;
    property fltAliquotaFcp                   : Double  read FAliquotaFcp                   write FAliquotaFcp                  ;
    property fltValorFcpDestino               : Double  read FValorFcpDestino               write FValorFcpDestino              ;
    property blnGrava                         : Boolean read FGrava                         write FGrava                        ;
  end;

type
  TDadosCTe = class(TObject)
  private
    FAutoIncrem: string;
    FSeqGer: string;
    FCodEmp: string;
    FEmpCli: string;
    FCFOP: string;
    FNaturezaOp: string;
    FSerie: string;
    FNumCTe: string;
    FDtEmissao: TDate;
    FChaveAcesso: string;
    FTomadorServico: string;
    FPapelTomadorServico: string;
    FProdutoPredominante: string;
    FDescricaoServico: string;
    FQtdeCargas: Double;
    FRNTRC: string;
    FClassificacaoTributaria: string;
    FPercentualReducaoBC: Double;
    FValorBC: Double;
    FAliquota: Double;
    FValorImposto: Double;
    FValorCredito: Double;
    FPortador: string;
    FPlanConPagar: string;
    FCndPagPagar: string;
    FPlanConReceber: string;
    FCndPagReceber: string;
    FGrava: Boolean;
    FValorFrete: Double;
    FDentroEstado: Boolean;
    FPartilha: TPartilhaCTe;
    FImpBoleto: Boolean;

    procedure pAlimentaCampo(var strCampo: string; strValor: string);
    procedure pAlimentaCampoDouble(var strCampo: Double; strValor: Double);
    procedure pAlimentaCampoCfop(intCgcCpf: Integer; strCfopF, strCfopJ: string; blnDentroEstado: boolean);
    procedure pTrataCfopDentroForaEstado(blnDentroEstado: Boolean);
    function fGravaDadosPartilha(qryDadosCTE: TUniQuery): Boolean;
  public
    blnPapelTomadorLiberado: Boolean;
    strPapelTomadorLiberado: string;

    constructor create();
    destructor Destroy(); override;
    procedure Copy(objDadosCte : TDadosCTe);

    procedure pLimpaDadosObjeto;
    function fGravaDadosCte(strTabela: string): Boolean;
    function fGravaMovCte: Boolean;
    function fGravaNotCte: Boolean;
    procedure pPopulaObjeto(strCodTra: string; intCgcCpf: Integer; blnDentroEstado: boolean);
    procedure pPopulaObjetoTraCid(strCodTra, strCodCid: string);
    procedure pPopulaObjetoTraReg(strCodTra, strCodReg: string);
    procedure pCarregaDados(strTabela, strNumCte, strCodEmp: String);

    {$IFNDEF LINUX}
    procedure pImprimirBoletoCTe(strCodCli: String);
    {$ENDIF}

    property strAutoIncrem              : string  read FAutoIncrem              write FAutoIncrem             ;
    property strSeqGer                  : string  read FSeqGer                  write FSeqGer                 ;
    property strCodEmp                  : string  read FCodEmp                  write FCodEmp                 ;
    property strEmpCli                  : string  read FEmpCli                  write FEmpCli                 ;
    property strCFOP                    : string  read FCFOP                    write FCFOP                   ;
    property strNaturezaOp              : string  read FNaturezaOp              write FNaturezaOp             ;
    property strSerie                   : string  read FSerie                   write FSerie                  ;
    property strNumCTe                  : string  read FNumCTe                  write FNumCTe                 ;
    property dtaDtEmissao               : TDate   read FDtEmissao               write FDtEmissao              ;
    property strChaveAcesso             : string  read FChaveAcesso             write FChaveAcesso            ;
    property strTomadorServico          : string  read FTomadorServico          write FTomadorServico         ;
    property strPapelTomadorServico     : string  read FPapelTomadorServico     write FPapelTomadorServico    ;
    property strProdutoPredominante     : string  read FProdutoPredominante     write FProdutoPredominante    ;
    property strDescricaoServico        : string  read FDescricaoServico        write FDescricaoServico       ;
    property fltQtdeCargas              : Double  read FQtdeCargas              write FQtdeCargas             ;
    property strRNTRC                   : string  read FRNTRC                   write FRNTRC                  ;
    property strClassificacaoTributaria : string  read FClassificacaoTributaria write FClassificacaoTributaria;
    property fltPercentualReducaoBC     : Double  read FPercentualReducaoBC     write FPercentualReducaoBC    ;
    property fltValorBC                 : Double  read FValorBC                 write FValorBC                ;
    property fltAliquota                : Double  read FAliquota                write FAliquota               ;
    property fltValorImposto            : Double  read FValorImposto            write FValorImposto           ;
    property fltValorCredito            : Double  read FValorCredito            write FValorCredito           ;
    property strPortador                : string  read FPortador                write FPortador               ;
    property strPlanConPagar            : string  read FPlanConPagar            write FPlanConPagar           ;
    property strCndPagPagar             : string  read FCndPagPagar             write FCndPagPagar            ;
    property strPlanConReceber          : string  read FPlanConReceber          write FPlanConReceber         ;
    property strCndPagReceber           : string  read FCndPagReceber           write FCndPagReceber          ;
    property blnGrava                   : Boolean read FGrava                   write FGrava                  ;
    property fltValorFrete              : Double  read FValorFrete              write FValorFrete             ;
    property blnDentroEstado            : Boolean read FDentroEstado;
    property objPartilha                : TPartilhaCTe read FPartilha           write FPartilha;
    property blnImpBoleto               : Boolean read FImpBoleto               write FImpBoleto;
  end;

implementation

{$IFNDEF LINUX}
uses
  untImpBoletosCTe, untTypesSistema;
{$ENDIF}

{ TDadosCTe }

procedure TDadosCTe.Copy(objDadosCte : TDadosCTe);
begin
  Self.strAutoIncrem              := objDadosCte.strAutoIncrem;
  Self.strSeqGer                  := objDadosCte.strSeqGer;
  Self.strCodEmp                  := objDadosCte.strCodEmp;
  Self.strEmpCli                  := objDadosCte.strEmpCli;
  Self.strCFOP                    := objDadosCte.strCFOP;
  Self.strNaturezaOp              := objDadosCte.strNaturezaOp;
  Self.strSerie                   := objDadosCte.strSerie;
  Self.strNumCTe                  := objDadosCte.strNumCTe;
  Self.strChaveAcesso             := objDadosCte.strChaveAcesso;
  Self.strTomadorServico          := objDadosCte.strTomadorServico;
  Self.strPapelTomadorServico     := objDadosCte.strPapelTomadorServico;
  Self.strProdutoPredominante     := objDadosCte.strProdutoPredominante;
  Self.strDescricaoServico        := objDadosCte.strDescricaoServico;
  Self.strRNTRC                   := objDadosCte.strRNTRC;
  Self.strClassificacaoTributaria := objDadosCte.strClassificacaoTributaria;
  Self.strPortador                := objDadosCte.strPortador;
  Self.strPlanConPagar            := objDadosCte.strPlanConPagar;
  Self.strCndPagPagar             := objDadosCte.strCndPagPagar;
  Self.strPlanConReceber          := objDadosCte.strPlanConReceber;
  Self.strCndPagReceber           := objDadosCte.strCndPagReceber;
  Self.fltQtdeCargas              := objDadosCte.fltQtdeCargas;
  Self.fltPercentualReducaoBC     := objDadosCte.fltPercentualReducaoBC;
  Self.fltValorBC                 := objDadosCte.fltValorBC;
  Self.fltAliquota                := objDadosCte.fltAliquota;
  Self.fltValorImposto            := objDadosCte.fltValorImposto;
  Self.fltValorCredito            := objDadosCte.fltValorCredito;
  Self.fltValorFrete              := objDadosCte.fltValorFrete;
  Self.dtaDtEmissao               := objDadosCte.dtaDtEmissao;
  Self.blnGrava                   := objDadosCte.blnGrava;
  Self.blnImpBoleto               := objDadosCte.blnImpBoleto;
  Self.blnPapelTomadorLiberado    := objDadosCte.blnPapelTomadorLiberado;
  Self.strPapelTomadorLiberado    := objDadosCte.strPapelTomadorLiberado;
  Self.objPartilha.Assign(objDadosCte.objPartilha);
end;

constructor TDadosCTe.create;
begin
  inherited Create;
  pLimpaDadosObjeto;
  Self.FPartilha := TPartilhaCTe.Create();
end;

destructor TDadosCTe.Destroy;
begin
  FreeAndNil(Self.FPartilha);
  inherited;
end;

function TDadosCTe.fGravaDadosPartilha(qryDadosCTE: TUniQuery): Boolean;
begin
  Result := (not qryDadosCte.IsEmpty);
  if Result then
    Result := (Self.FPapelTomadorServico = '9 - Não contribuinte');
end;

procedure TDadosCTe.pAlimentaCampo(var strCampo: string; strValor: string);
begin
  if fEmptyStr(strCampo) then
    strCampo := strValor;
end;

procedure TDadosCTe.pAlimentaCampoCfop(intCgcCpf: Integer; strCfopF,
  strCfopJ: string; blnDentroEstado: boolean);
begin
  if not fEmptyStr(Self.FCFOP) then
    Exit;

  if (Self.FTomadorServico = '0 - Remetente') then
    Self.FCFOP := strCfopJ
  else
  if intCgcCpf = 1 then
    Self.FCFOP := strCfopJ
  else
    Self.FCFOP := strCfopF;

  pTrataCfopDentroForaEstado(blnDentroEstado);
end;

procedure TDadosCTe.pAlimentaCampoDouble(var strCampo: Double;
  strValor: Double);
begin
  if strCampo = 0 then
    strCampo := strValor;
end;

procedure TDadosCTe.pCarregaDados(strTabela, strNumCte, strCodEmp: String);
var
  qryDadosCte: TUniQuery;
begin
  qryDadosCte := fCriaQuery();
  try
    qryDadosCte.SQL.Add('SELECT *');
    qryDadosCte.SQL.Add('FROM ' + strTabela);
    qryDadosCte.SQL.Add(' WHERE CTE_CODEMP = :CODEMP');
    qryDadosCte.SQL.Add('   AND CTE_NUMCTE = :NUMCTE');

    qryDadosCte.ParamByName('CODEMP').AsString := strCodEmp;
    qryDadosCte.ParamByName('NUMCTE').AsString := strNumCte;

    qryDadosCte.Open;

    Self.FAutoIncrem              := qryDadosCte.FieldByName('AUTOINCREM').AsString;
    Self.FSeqGer                  := qryDadosCte.FieldByName('CTE_SEQGER').AsString;
    Self.FCodEmp                  := qryDadosCte.FieldByName('CTE_CODEMP').AsString;
    Self.FEmpCli                  := qryDadosCte.FieldByName('CTE_EMPCLI').AsString;
    Self.FNumCTe                  := qryDadosCte.FieldByName('CTE_NUMCTE').AsString;
    Self.FCFOP                    := qryDadosCte.FieldByName('CTE_CFOP__').AsString;
    Self.FNaturezaOp              := qryDadosCte.FieldByName('CTE_NATOPE').AsString;
    Self.FSerie                   := qryDadosCte.FieldByName('CTE_SERIE_').AsString;
    Self.FDtEmissao               := qryDadosCte.FieldByName('CTE_DTAEMI').AsDateTime;
    Self.FTomadorServico          := qryDadosCte.FieldByName('CTE_TOMSER').AsString;
    Self.FPapelTomadorServico     := qryDadosCte.FieldByName('CTE_PAPTOM').AsString;
    Self.FRNTRC                   := qryDadosCte.FieldByName('CTE_RNTRC_').AsString;
    Self.FProdutoPredominante     := qryDadosCte.FieldByName('CTE_PROPRE').AsString;
    Self.FDescricaoServico        := qryDadosCte.FieldByName('CTE_DESSER').AsString;
    Self.FQtdeCargas              := qryDadosCte.FieldByName('CTE_QTDCAR').AsFloat;
    Self.FClassificacaoTributaria := qryDadosCte.FieldByName('CTE_CLATRI').AsString;
    Self.FPercentualReducaoBC     := qryDadosCte.FieldByName('CTE_PERRBC').AsFloat;
    Self.FValorBC                 := qryDadosCte.FieldByName('CTE_VLRBCI').AsFloat;
    Self.FAliquota                := qryDadosCte.FieldByName('CTE_ALIQUO').AsFloat;
    Self.FValorImposto            := qryDadosCte.FieldByName('CTE_VLRIMP').AsFloat;
    Self.FValorCredito            := qryDadosCte.FieldByName('CTE_VLRCRE').AsFloat;
    Self.FPortador                := qryDadosCte.FieldByName('CTE_CODPOR').AsString;
    Self.FPlanConPagar            := qryDadosCte.FieldByName('CTE_PLCTPG').AsString;
    Self.FCndPagPagar             := qryDadosCte.FieldByName('CTE_CNDPAG').AsString;
    Self.FPlanConReceber          := qryDadosCte.FieldByName('CTE_PLCTRC').AsString;
    Self.FCndPagReceber           := qryDadosCte.FieldByName('CTE_CNDREC').AsString;
    Self.FValorFrete              := qryDadosCte.FieldByName('CTE_VLRFRE').AsFloat;

    qryDadosCte.Close;
    qryDadosCte.SQL.Clear;
    qryDadosCte.SQL.Add('SELECT * FROM PARCTE WHERE PAR_SEQGER = :SEQGER');
    qryDadosCte.ParamByName('SEQGER').AsString := Self.FAutoIncrem;
    qryDadosCte.Open;

    if fGravaDadosPartilha(qryDadosCte) then
    begin
      Self.FPartilha.FValorBaseCalculoIcmsUfDestino := qryDadosCte.FieldByName('PAR_BCIUFD').AsFloat;
      Self.FPartilha.FAliquotaIcmsInternaUfDestino  := qryDadosCte.FieldByName('PAR_AIIUFD').AsFloat;
      Self.FPartilha.FAliquotaIcmsInterestadual     := qryDadosCte.FieldByName('PAR_AICMSI').AsFloat;
      Self.FPartilha.FValorIcmsPartilhaTermino      := qryDadosCte.FieldByName('PAR_ICMSPT').AsFloat;
      Self.FPartilha.FValorIcmsPartilhaInicio       := qryDadosCte.FieldByName('PAR_ICMSPI').AsFloat;
      Self.FPartilha.FAliquotaFcp                   := qryDadosCte.FieldByName('PAR_ALQFCP').AsFloat;
      Self.FPartilha.FValorFcpDestino               := qryDadosCte.FieldByName('PAR_VLRFCP').AsFloat;
      Self.FPartilha.FGrava := True;
    end;
  finally
    FreeAndNil(qryDadosCte);
  end;
end;

{$IFNDEF LINUX}
procedure TDadosCTe.pImprimirBoletoCTe(strCodCli: String);
var
  frmImpBoletosCTe: TfrmImpBoletosCTe;
begin
  if (not blnGrava) or (not blnImpBoleto) then
    Exit;

  pCriarFormularios(TfrmImpBoletosCTe, frmImpBoletosCTe);
  try
    frmImpBoletosCTe.strNumCte := strNumCte;
    frmImpBoletosCTe.strCodEmp := strCodEmp;
    frmImpBoletosCTe.strCodCli := strCodCli;

    frmImpBoletosCTe.ShowModal;
  finally
    pFreeAndNil(frmImpBoletosCTe);
  end;
end;
{$ENDIF}

procedure TDadosCTe.pLimpaDadosObjeto;
begin
  Self.FAutoIncrem := '';
  Self.FSeqGer := '';
  Self.FCodEmp := '';
  Self.FEmpCli := '';
  Self.FCFOP := '';
  Self.FNaturezaOp := '';
  Self.FSerie := '';
  Self.FNumCTe := '';
  Self.FDtEmissao := 0;
  Self.FChaveAcesso := '';
  Self.FTomadorServico := '';
  Self.FPapelTomadorServico := '';
  Self.FProdutoPredominante := '';
  Self.FDescricaoServico := '';
  Self.FQtdeCargas := 1;
  Self.FRNTRC := '';
  Self.FClassificacaoTributaria := '';
  Self.FPercentualReducaoBC := 0;
  Self.FValorBC := 0;
  Self.FAliquota := 0;
  Self.FValorImposto := 0;
  Self.FValorCredito := 0;
  Self.FPortador := '';
  Self.FPlanConPagar := '';
  Self.FCndPagPagar := '';
  Self.FPlanConReceber := '';
  Self.FCndPagReceber := '';
  Self.FGrava := False;
  Self.FValorFrete := 0;
  Self.FDentroEstado := True;
  Self.blnPapelTomadorLiberado := False;
  Self.strPapelTomadorLiberado := '';
  Self.blnImpBoleto := False;
end;

function TDadosCTe.fGravaDadosCte(strTabela: string): Boolean;
var
  qryDadosCte: TUniQuery;
begin
  Result := False;
  if fEmptyStr(strTabela) then
    Exit;

  qryDadosCte := fCriaQuery();
  try
    try
      qryDadosCte.SQL.Add('SELECT * FROM ' + strTabela + ' WHERE AUTOINCREM = :AUTINC');
      qryDadosCte.ParamByName('AUTINC').AsString := Self.FAutoIncrem;
      qryDadosCte.Open;

      if qryDadosCte.IsEmpty then
      begin
        qryDadosCte.Insert;
        Self.FAutoIncrem := fRetAutoIncrem(strTabela, Self.FCodEmp);
        Self.FNumCTe     := fStrZero(fRetSequencial('PRO_CT', Self.FCodEmp), 9);
        Self.FDtEmissao  := VS_Date;
        qryDadosCte.FieldByName('AUTOINCREM').AsString    := Self.FAutoIncrem;
        qryDadosCte.FieldByName('CTE_SEQGER').AsString    := Self.FSeqGer;
        qryDadosCte.FieldByName('CTE_CODEMP').AsString    := Self.FCodEmp;
        qryDadosCte.FieldByName('CTE_EMPCLI').AsString    := Self.FEmpCli;
        qryDadosCte.FieldByName('CTE_NUMCTE').AsString    := Self.FNumCTe;
      end
      else
      begin
        if not fEmptyStr(fCampoTabela('CTE_ACESSO', strTabela, ['AUTOINCREM'], [Self.FAutoIncrem])) then
          Raise ExceptionAutCom.Create('Este CTe já foi autorizado. Alteração não permitida!');

        qryDadosCte.Edit;
      end;

      qryDadosCte.FieldByName('CTE_CFOP__').AsString    := Self.FCFOP;
      qryDadosCte.FieldByName('CTE_NATOPE').AsString    := Self.FNaturezaOp;
      qryDadosCte.FieldByName('CTE_SERIE_').AsString    := Self.FSerie;
      qryDadosCte.FieldByName('CTE_DTAEMI').AsDateTime  := Self.FDtEmissao;
      qryDadosCte.FieldByName('CTE_TOMSER').AsString    := Self.FTomadorServico;
      qryDadosCte.FieldByName('CTE_PAPTOM').AsString    := Self.FPapelTomadorServico;
      qryDadosCte.FieldByName('CTE_RNTRC_').AsString    := Self.FRNTRC;
      qryDadosCte.FieldByName('CTE_PROPRE').AsString    := Self.FProdutoPredominante;
      qryDadosCte.FieldByName('CTE_DESSER').AsString    := Self.FDescricaoServico;
      qryDadosCte.FieldByName('CTE_QTDCAR').AsFloat     := Self.FQtdeCargas;
      qryDadosCte.FieldByName('CTE_CLATRI').AsString    := Self.FClassificacaoTributaria;
      qryDadosCte.FieldByName('CTE_PERRBC').AsFloat     := Self.FPercentualReducaoBC;
      qryDadosCte.FieldByName('CTE_VLRBCI').AsFloat     := Self.FValorBC;
      qryDadosCte.FieldByName('CTE_ALIQUO').AsFloat     := Self.FAliquota;
      qryDadosCte.FieldByName('CTE_VLRIMP').AsFloat     := Self.FValorImposto;
      qryDadosCte.FieldByName('CTE_VLRCRE').AsFloat     := Self.FValorCredito;
      qryDadosCte.FieldByName('CTE_CODPOR').AsString    := Self.FPortador;
      qryDadosCte.FieldByName('CTE_PLCTPG').AsString    := Self.FPlanConPagar;
      qryDadosCte.FieldByName('CTE_CNDPAG').AsString    := Self.FCndPagPagar;
      qryDadosCte.FieldByName('CTE_PLCTRC').AsString    := Self.FPlanConReceber;
      qryDadosCte.FieldByName('CTE_CNDREC').AsString    := Self.FCndPagReceber;
      qryDadosCte.FieldByName('CTE_VLRFRE').AsFloat     := Self.FValorFrete;

      qryDadosCte.Post;

      if Self.FPartilha.FGrava then
      begin
        qryDadosCte.Close;
        qryDadosCte.SQL.Clear;
        qryDadosCte.SQL.Add('SELECT * FROM PARCTE WHERE PAR_SEQGER = :SEQGER');
        qryDadosCte.ParamByName('SEQGER').AsString := Self.FAutoIncrem;
        qryDadosCte.Open;

        if qryDadosCte.IsEmpty then
        begin
          qryDadosCte.Insert;
          qryDadosCte.FieldByName('PAR_SEQGER').AsString := Self.FAutoIncrem;
        end
        else
          qryDadosCte.Edit;

        qryDadosCte.FieldByName('PAR_BCIUFD').AsFloat := Self.FPartilha.FValorBaseCalculoIcmsUfDestino;
        qryDadosCte.FieldByName('PAR_AIIUFD').AsFloat := Self.FPartilha.FAliquotaIcmsInternaUfDestino;
        qryDadosCte.FieldByName('PAR_AICMSI').AsFloat := Self.FPartilha.FAliquotaIcmsInterestadual;
        qryDadosCte.FieldByName('PAR_ICMSPT').AsFloat := Self.FPartilha.FValorIcmsPartilhaTermino;
        qryDadosCte.FieldByName('PAR_ICMSPI').AsFloat := Self.FPartilha.FValorIcmsPartilhaInicio;
        qryDadosCte.FieldByName('PAR_ALQFCP').AsFloat := Self.FPartilha.FAliquotaFcp;
        qryDadosCte.FieldByName('PAR_VLRFCP').AsFloat := Self.FPartilha.FValorFcpDestino;

        qryDadosCte.Post;
      end;

      Result := True;
    except
      On E: Exception do
      begin
        Result := False;
        qryDadosCte.Cancel;
        pMensagensErro(E.Message, '[fGravaDadosCte]');
      end;
    end;
  finally
    FreeAndNil(qryDadosCte);
  end;
end;

function TDadosCTe.fGravaMovCte: Boolean;
begin
  Result := fGravaDadosCte('MOVCTE');
end;

function TDadosCTe.fGravaNotCte: Boolean;
begin
  Result := fGravaDadosCte('NOTCTE');
end;

procedure TDadosCTe.pPopulaObjeto(strCodTra: string; intCgcCpf: Integer; blnDentroEstado: boolean);
var
  qryCadTra: TUniQuery;
begin
  FDentroEstado := blnDentroEstado;
  qryCadTra := fCriaQuery();
  try
    qryCadTra.SQL.Add('SELECT ');
    qryCadTra.SQL.Add('  TRA_EMPRES, ');
    qryCadTra.SQL.Add('  TRA_CFOP__, ');
    qryCadTra.SQL.Add('  TRA_CFOPJU, ');
    qryCadTra.SQL.Add('  TRA_NATOPE, ');
    qryCadTra.SQL.Add('  TRA_SERIE_, ');
    qryCadTra.SQL.Add('  TRA_TOMSER, ');
    qryCadTra.SQL.Add('  TRA_PAPTOM, ');
    qryCadTra.SQL.Add('  TRA_CLATRI, ');
    qryCadTra.SQL.Add('  TRA_PROPRE, ');
    qryCadTra.SQL.Add('  TRA_DESSER, ');
    qryCadTra.SQL.Add('  TRA_RNTRC_, ');
    qryCadTra.SQL.Add('  TRA_CODPOR, ');
    qryCadTra.SQL.Add('  TRA_PLCTPG, ');
    qryCadTra.SQL.Add('  TRA_CNDPAG, ');
    qryCadTra.SQL.Add('  TRA_PLCTRC, ');
    qryCadTra.SQL.Add('  TRA_CNDREC, ');
    qryCadTra.SQL.Add('  TRA_ALIQUO ');
    qryCadTra.SQL.Add('FROM ');
    qryCadTra.SQL.Add('  CADTRA ');
    qryCadTra.SQL.Add('WHERE ');
    qryCadTra.SQL.Add('  TRA_CODTRA = :CODTRA ');

    qryCadTra.ParamByName('CODTRA').AsString := strCodTra;
    qryCadTra.Open;

    if qryCadTra.IsEmpty then
      Raise Exception.Create('Erro ao tentar obter dados da Transportadora para emitir CT-e' + #13 + 'Entre em contato com a Citel');

    Self.FCodEmp                  := qryCadTra.FieldByName('TRA_EMPRES').AsString;

    pAlimentaCampo(Self.FTomadorServico, qryCadTra.FieldByName('TRA_TOMSER').AsString);
    pAlimentaCampoCFOP(intCgcCpf, qryCadTra.FieldByName('TRA_CFOP__').AsString, qryCadTra.FieldByName('TRA_CFOPJU').AsString, blnDentroEstado);
    pAlimentaCampo(Self.FNaturezaOp, qryCadTra.FieldByName('TRA_NATOPE').AsString);
    pAlimentaCampo(Self.FSerie, qryCadTra.FieldByName('TRA_SERIE_').AsString);
    pAlimentaCampo(Self.FClassificacaoTributaria, qryCadTra.FieldByName('TRA_CLATRI').AsString);
    pAlimentaCampo(Self.FProdutoPredominante, qryCadTra.FieldByName('TRA_PROPRE').AsString);
    pAlimentaCampo(Self.FDescricaoServico, qryCadTra.FieldByName('TRA_DESSER').AsString);
    pAlimentaCampo(Self.FRNTRC, qryCadTra.FieldByName('TRA_RNTRC_').AsString);
    pAlimentaCampo(Self.FPortador, qryCadTra.FieldByName('TRA_CODPOR').AsString);
    pAlimentaCampo(Self.FPlanConPagar, qryCadTra.FieldByName('TRA_PLCTPG').AsString);
    pAlimentaCampo(Self.FCndPagPagar, qryCadTra.FieldByName('TRA_CNDPAG').AsString);
    pAlimentaCampo(Self.FPlanConReceber, qryCadTra.FieldByName('TRA_PLCTRC').AsString);
    pAlimentaCampo(Self.FCndPagReceber, qryCadTra.FieldByName('TRA_CNDREC').AsString);
    pAlimentaCampoDouble(Self.FAliquota, qryCadTra.FieldByName('TRA_ALIQUO').AsFloat);
  finally
    FreeAndNil(qryCadTra);
  end;
end;

procedure TDadosCTe.pPopulaObjetoTraCid(strCodTra, strCodCid: string);
var
  qryFreTra: TUniQuery;
begin
  if not fCfgSis('UTICTE', varBoolean) then
    Exit;

  qryFreTra := fCriaQuery;
  try
    qryFreTra.SQL.Add('SELECT');
    qryFreTra.SQL.Add('  FRE_TOMADO,');
    qryFreTra.SQL.Add('  FRE_ALIQUO');
    qryFreTra.SQL.Add('FROM FRETRA');
    qryFreTra.SQL.Add('WHERE FRE_CODTRA = :CODTRA');
    qryFreTra.SQL.Add('  AND FRE_CODCID = :CODCID');

    qryFreTra.ParamByName('CODTRA').AsString := strCodTra;
    qryFreTra.ParamByName('CODCID').AsString := strCodCid;
    qryFreTra.Open;

    if qryFreTra.FieldByName('FRE_TOMADO').AsString = 'E' then
      Self.FTomadorServico := '0 - Remetente'
    else
    if qryFreTra.FieldByName('FRE_TOMADO').AsString = 'D' then
      Self.FTomadorServico := '3 - Destinatário';

    if qryFreTra.FieldByName('FRE_ALIQUO').AsFloat > 0 then
      Self.FAliquota := qryFreTra.FieldByName('FRE_ALIQUO').AsFloat;
  finally
    FreeAndNil(qryFreTra);
  end;


end;

procedure TDadosCTe.pPopulaObjetoTraReg(strCodTra, strCodReg: string);
var
  qryTraReg: TUniQuery;
begin
  If not fCfgSis('UTICTE', varBoolean) Then
    Exit;

  qryTraReg := fCriaQuery;
  Try
    qryTraReg.SQL.Add('SELECT');
    qryTraReg.SQL.Add('  TRE_TOMADO ');
    qryTraReg.SQL.Add('FROM TRAREG');
    qryTraReg.SQL.Add('WHERE TRE_CODTRA = :CODTRA');
    qryTraReg.SQL.Add('  AND TRE_CODREG = :CODREG');

    qryTraReg.ParamByName('CODTRA').AsString := strCodTra;
    qryTraReg.ParamByName('CODREG').AsString := strCodReg;
    qryTraReg.Open;

    if qryTraReg.FieldByName('TRE_TOMADO').AsString = 'E' then
      Self.FTomadorServico := '0 - Remetente'
    else
    if qryTraReg.FieldByName('TRE_TOMADO').AsString = 'D' then
      Self.FTomadorServico := '3 - Destinatário';
  Finally
    FreeAndNil(qryTraReg);
  End;
end;

procedure TDadosCTe.pTrataCfopDentroForaEstado(blnDentroEstado: Boolean);
begin
  if fEmptyStr(Self.FCFOP) then
    Exit;

  if (blnDentroEstado) then
    Self.FCFOP := '5' + RightStr(Self.FCFOP, 3)
  else
    Self.FCFOP := '6' + RightStr(Self.FCFOP, 3);
end;

{ TPartilhaCTe }

procedure TPartilhaCTe.Assign(AOrigem: TPartilhaCTe);
begin
  Self.fltValorBaseCalculoIcmsUfDestino := AOrigem.fltValorBaseCalculoIcmsUfDestino;
  Self.fltAliquotaIcmsInternaUfDestino  := AOrigem.fltAliquotaIcmsInternaUfDestino;
  Self.fltAliquotaIcmsInterestadual     := AOrigem.fltAliquotaIcmsInterestadual;
  Self.fltValorIcmsPartilhaTermino      := AOrigem.fltValorIcmsPartilhaTermino;
  Self.fltValorIcmsPartilhaInicio       := AOrigem.fltValorIcmsPartilhaInicio;
  Self.fltAliquotaFcp                   := AOrigem.fltAliquotaFcp;
  Self.fltValorFcpDestino               := AOrigem.fltValorFcpDestino;
  Self.blnGrava                         := AOrigem.blnGrava;
end;

constructor TPartilhaCTe.Create;
begin
  inherited Create;
  pLimpaDadosObjeto;
end;

procedure TPartilhaCTe.pAlimentarPadraoAliquotas(const fltAliqIcmsInternaUfDestino: Double; const blnDentroEstado: Boolean; const strUFEntrega: string);
begin
  if not blnDentroEstado then
  begin
    if (Self.fltAliquotaIcmsInternaUfDestino <= 0) then
      Self.fltAliquotaIcmsInternaUfDestino := fltAliqIcmsInternaUfDestino;

    if (Self.fltAliquotaIcmsInterestadual <= 0) then
      Self.pObterAliquotaInterestadual(strUFEntrega);
  end;
end;

procedure TPartilhaCTe.pLimpaDadosObjeto;
begin
  Self.FValorBaseCalculoIcmsUfDestino := 0;
  Self.FAliquotaIcmsInternaUfDestino := 0;
  Self.FAliquotaIcmsInterestadual := 0;
  Self.FValorIcmsPartilhaTermino := 0;
  Self.FValorIcmsPartilhaInicio := 0;
  Self.FAliquotaFcp := 0;
  Self.FValorFcpDestino := 0;
  Self.FGrava := False;
end;

procedure TPartilhaCTe.pObterAliquotaInterestadual(strUFEndEntrega: string);
begin
  if (Pos(fRetUFEmpresa, 'RS,SC,SP,MG,RJ,PR') > 0) and
     (Pos(strUFEndEntrega, 'RS,SC,SP,MG,RJ,PR') <= 0) Then
  Begin
    Self.FAliquotaIcmsInterestadual := 7;
  End
  Else
  Begin
    Self.FAliquotaIcmsInterestadual := 12;
  End;
end;

end.

