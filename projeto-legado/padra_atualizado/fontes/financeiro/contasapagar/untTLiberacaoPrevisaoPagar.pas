unit untTLiberacaoPrevisaoPagar;

interface

uses
  System.Generics.Collections, System.SysUtils, untTCadPag, untTCadPagRepository,
  UniCLientDataset, Aurelius.Types.Nullable;

type
  TLiberacaoPrevisaoPagar = class
  private
    blnCriouObj: Boolean;
    FCadPag: TList<TCadPag>;
    FCadPagRep: TCadPagRepository;
    FNomeForm: String;
    FMotivoReprova,
    FCodigoPortador,
    FCodigoCentroDeCusto,
    FCodigoPlanoDeContas,
    FHistorico          : String;

    procedure pInserirMensagemReprova(objCadPag: TCadPag);
  public
    constructor Create(strNomeForm: String); reintroduce;
    destructor Destroy; override;

    property strMotivoReprova: String read FMotivoReprova write FMotivoReprova;
    property strCodigoPortador: String read FCodigoPortador write FCodigoPortador;
    property strCodigoCentroDeCusto: String read FCodigoCentroDeCusto write FCodigoCentroDeCusto;
    property strCodigoPlanoDeContas: String read FCodigoPlanoDeContas write FCodigoPlanoDeContas;
    property strHistorico: String read FHistorico write FHistorico;

    procedure pLimpaDados;
    procedure pAddPagar(strAutoincrem: String);
    procedure pAprovar;
    procedure pReprovar;

    class function fRetornaAvisosPrevisionamentoCTPNaoLidos(strCOdigoOperador: String): TUniClientDataset;
  end;

implementation

{ TLiberacapPrevisaoPagar }

uses untFuncoesSimples, untObjectManager, untLogCtp, Uni;

constructor TLiberacaoPrevisaoPagar.Create(strNomeForm: String);
begin
  inherited Create;
  FNomeForm := strNomeForm;
  FCadPag := TList<TCadPag>.Create;
  FCadPagRep := TCadPagRepository.Create;

  frwk := fCriaObjManager(blnCriouObj);

  FHistorico           := '';
  FMotivoReprova       := '';
  FCodigoPortador      := '';
  FCodigoCentroDeCusto := '';
  FCodigoPlanoDeContas := '';
end;

destructor TLiberacaoPrevisaoPagar.Destroy;
begin
  If blnCriouObj Then
    FreeAndNil(frwk);

  FreeAndNil(FCadPagRep);
  FreeAndNil(FCadPag);
  inherited;
end;

class function TLiberacaoPrevisaoPagar.fRetornaAvisosPrevisionamentoCTPNaoLidos(
  strCOdigoOperador: String): TUniClientDataset;
  Var
    qryConsulta: TUniQuery;
Begin
  Try
    qryConsulta := fCriarQuery('SELECT M.*, E.OPE_NOMOPE, F.FOR_NOMFOR, "D" AS PRE_MARDES, ' +
                               '   CONCAT(M.PRE_NUMDUP, M.PRE_PARCEL, "-", M.PRE_CODEMP, "-", M.PRE_SERIE_) AS NUMDUP, ' +
                               '   CONCAT(M.PRE_OPEENV, "-", E.OPE_NOMOPE) AS OPEENV ' +
                               'FROM MSGPRE M             ' +
                               'LEFT JOIN CADFOR F ON F.FOR_CODFOR=M.PRE_CODFOR ' +
                               'LEFT JOIN CADOPE E ON E.OPE_CODOPE=M.PRE_OPEENV ' +
                               'WHERE M.PRE_OPEREC=' + strCodigoOperador.QuotedString +
                               '  AND M.PRE_MSGLID="N"');
    qryConsulta.Open;
  Finally
    Result := fCriaClientDatset(qryConsulta);

    FreeAndNil(qryConsulta);
  End;
end;

procedure TLiberacaoPrevisaoPagar.pAddPagar(strAutoincrem: String);
var
  objCadPag: TCadPag;
begin
  objCadPag := FCadPagRep.fRetDuplicata(strAutoincrem);
  FCadPag.Add(objCadPag);
end;

procedure TLiberacaoPrevisaoPagar.pAprovar;
  var
    objCadPag: TCadPag;
begin
  For objCadPag In FCadPag Do
  Begin
    objCadPag.dtaDtaApr := fNow;
    objCadPag.strOpeApr := strLoginUsuarioLogado;
    objCadPag.strPrevis := 'N';

    If Not FCodigoPortador.IsEmpty Then
      objCadPag.strCodPor := strCodigoPortador;

    If Not FCodigoPlanoDeContas.IsEmpty Then
      objCadPag.strCodCta := strCodigoPlanoDeContas;

    If Not FCodigoCentroDeCusto.IsEmpty Then
      objCadPag.strCodEve := strCodigoCentroDeCusto;

    If Not FHistorico.IsEmpty Then
    Begin
      If objCadPag.strHist01 = SNull Then
        objCadPag.strHist01 := FHistorico
      Else
        objCadPag.strHist01 := objCadPag.strHist01.Value + ' - ' + FHistorico;
    End;

    objCadPag.strOpeRep := SNull;
    objCadPag.dtaDtaRep := SNull;
    objCadPag.strMotRep := SNull;

    pGravaLogCtp(objCadPag, 'APROVAÇÃO DE PREVISIONAMENTO DE CONTAS A PAGAR', FNomeForm);
  End;
  frwk.objDBManager.Flush;
end;

procedure TLiberacaoPrevisaoPagar.pInserirMensagemReprova(objCadPag: TCadPag);
begin
  Try
    fExecutaSQL('INSERT INTO MSGPRE ( ' +
                '   PRE_DTAMSG,       ' +
                '   PRE_OPEENV,       ' +
                '   PRE_OPEREC,       ' +
                '   PRE_ASSUNT,       ' +
                '   PRE_MOTIVO,       ' +
                '   PRE_NUMDUP,       ' +
                '   PRE_PARCEL,       ' +
                '   PRE_CODEMP,       ' +
                '   PRE_SERIE_,       ' +
                '   PRE_CODFOR,       ' +
                '   PRE_SEQBAI        ' +
                ') VALUES (           ' +
                FormatDateTime('yyyy-mm-dd hh:mm:ss', fNow).QuotedString + ', ' +
                strLoginUsuarioLogado.QuotedString + ', ' +
                objCadPag.strCodOpe.QuotedString + ', ' +
                '"Reprovado o previsionamento do contas a pagar. Duplicata: ' + objCadPag.strNumDup + objCadPag.strParcel + '-' + objCadPag.strCodEmp + '-' + objCadPag.strCodFor + '", ' +
                FMotivoReprova.QuotedString + ', ' +
                objCadPag.strNumDup.QuotedString + ', ' +
                objCadPag.strParcel.QuotedString + ', ' +
                objCadPag.strCodEmp.QuotedString + ', ' +
                objCadPag.strSerie.QuotedString + ', ' +
                objCadPag.strCodFor.QuotedString + ', ' +
                objCadPag.intSeqBai.Value.ToString + ')');
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TLiberacaoPrevisaoPagar.pReprovar;
  var
    objCadPag: TCadPag;
begin
  For objCadPag In FCadPag Do
  Begin
    objCadPag.dtaDtaRep := fNow;
    objCadPag.strOpeRep := strLoginUsuarioLogado;
    objCadPag.strMotRep := FMotivoReprova;

    If Not FCodigoPortador.IsEmpty Then
      objCadPag.strCodPor := strCodigoPortador;

    If Not FCodigoPlanoDeContas.IsEmpty Then
      objCadPag.strCodCta := strCodigoPlanoDeContas;

    If Not FCodigoCentroDeCusto.IsEmpty Then
      objCadPag.strCodEve := strCodigoCentroDeCusto;

    If Not FHistorico.IsEmpty Then
    Begin
      If objCadPag.strHist01 = SNull Then
        objCadPag.strHist01 := FHistorico
      Else
        objCadPag.strHist01 := objCadPag.strHist01.Value + ' - ' + FHistorico;
    End;

    objCadPag.strOpeApr := SNull;
    objCadPag.dtaDtaApr := SNull;

    pGravaLogCtp(objCadPag, 'REPROVA DE PREVISIONAMENTO DE CONTAS A PAGAR', FNomeForm);

    pInserirMensagemReprova(objCadPag);
  End;
  frwk.objDBManager.Flush;
end;

procedure TLiberacaoPrevisaoPagar.pLimpaDados;
begin
  FCadPag.Clear;
end;

end.
