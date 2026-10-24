unit cadastro.Model.AcessorioLocacao;

interface

uses
  Uni, Classes, SysUtils, Controls, untTypesLocEqu, untCadLote;

type

  TEquipamentoLocacaoAcessorio = Class
  private
    FAnoFab: Integer;
    FAutInc: String;
    FCodigo: String;
    FCodIte: String;
    FDesIte: String;
    FDatAqu: TDateTime;
    FDescri: String;
    FDtaVen: TDateTime;
    FDtUlMn: TDateTime;
    FEspecf: String;
    FGarant: Integer;
    FLocFis: String;
    FModelo: String;
    FRpUlMn: String;
    FStatus: String;
    FValAqu: Double;
    FMensagem: String;
    FItemFracionado: Boolean;
    FBlnTrv: Boolean;
    FNumLot: String;
    FSlMensagemTrava: TStringList;
    FblnCodigoItemValido: Boolean;
    FVlrAqu: Double;
    FVlrCau: Double;
    FVlrAdc: Double;

    function fValidarItemEhAcessorioLocacao(
      const strImpLst, strRealoc, strTipLoc: String; blnListarTodos: Boolean): Boolean;

    function GetAnoFab: Integer;
    function GetAutInc: String;
    function GetCodigo: String;
    function GetCodIte: String;
    function GetDesIte: String;
    function GetDatAqu: TDateTime;
    function GetDescri: String;
    function GetDtaVen: TDateTime;
    function GetDtUlMn: TDateTime;
    function GetEspecf: String;
    function GetGarant: Integer;
    function GetLocFis: String;
    function GetModelo: String;
    function GetRpUlMn: String;
    function GetStatus: String;
    function GetValAqu: Double;
    function GetMensagem: String;

    procedure SetAutInc(const AValue: String);
    procedure SetCodigo(const AValue: String);
    procedure SetDescri(const AValue: String);
    procedure SetDatAqu(const AValue: TDateTime);
    procedure SetValAqu(const AValue: Double);
    procedure SetGarant(const AValue: Integer);
    procedure SetDtUlMn(const AValue: TDateTime);
    procedure SetRpUlMn(const AValue: String);
    procedure SetModelo(const AValue: String);
    procedure SetAnoFab(const AValue: Integer);
    procedure SetEspecf(const AValue: String);
    procedure SetLocFis(const AValue: String);
    procedure SetCodIte(const AValue: String);
    procedure SetDesIte(const AValue: String);
    procedure SetDtaven(const AValue: TDateTime);
    procedure SetStatus(const AValue: String);
    procedure SetMensagem(const AValue: String);
    function GetIteFra: Boolean;
    procedure SetIteFra(const AValue: Boolean);
    function GetNumLot: String;
    procedure SetNumLot(const AValue: String);
    function GetMsgTrv: String;
    function GetCodIteV: Boolean;
    function GetVlrAqu: Double;
    procedure SetVlrAqu(const AValue: Double);
    function GetVlrCau: Double;
    procedure SetVlrCau(const Value: Double);
    function GetVlrdAdt: Double;
    procedure SetVlrAdc(const AValue: Double);
  public
    constructor Create;
    destructor Destroy; override;

    procedure pCarregaEquipamento(const strAutInc: String = ''; const strCodAcl: String = '');
    procedure pLimpar;
    function fCarregaAcessorio(const strCodAcl: String): Boolean;
    function fValidaItemLocacao(strCodIte: String; blnListarTodos: Boolean = False): Boolean;
    function fValidaQuantidadeItemFracionado(const aQtd: Double): Boolean;
    function fValidaAcessorio(blnListarTodos: Boolean = False): Boolean;
    function fValidarItemAssociadoEquipamento(const strCodIte: String): Boolean;

    class procedure pAtivarAcessorio(const strAutInc: String);

    property AutInc: String read GetAutInc write SetAutInc;
    property Codigo: String read GetCodigo write SetCodigo;
    property Descricao: String read GetDescri write SetDescri;
    property DataAquisicao: TDateTime read GetDatAqu write SetDatAqu;
    property ValorAquisicao: Double read GetValAqu write SetValAqu;
    property Garantia: Integer read GetGarant write SetGarant;
    property DataUltimaManutencao: TDateTime read GetDtUlMn write SetDtUlMn;
    property ResponsavelUltimaManutencao: String read GetRpUlMn write SetRpUlMn;
    property Modelo: String read GetModelo write SetModelo;
    property AnoFabricacao: Integer read GetAnoFab write SetAnoFab;
    property Especificacao: String read GetEspecf write SetEspecf;
    property LocalizacaoFisica: String read GetLocFis write SetLocFis;
    property CodigoItem: String read GetCodIte write SetCodIte;
    property DescricaoItem: String read GetDesIte write SetDesIte;
    property DataVenda: TDateTime read GetDtaVen write SetDtaven;
    property Status: String read GetStatus write SetStatus;
    property Mensagem: String read GetMensagem write SetMensagem;
    property Fracionado: Boolean read GetIteFra write SetIteFra;
    property NumLoteItem: String read GetNumLot write SetNumLot;
    property MensagemTrava: String read GetMsgTrv;
    property blnCodigoItemValido: Boolean read  GetCodIteV;
    property ValorAqu: Double read GetVlrAqu write SetVlrAqu;
    property ValorCaucao: Double read GetVlrCau write SetVlrCau;
    property ValorAdicional: Double read GetVlrdAdt write SetVlrAdc;
  End;

  THerancaCadAceLoc = Class
  private
    FobjEquAce: TEquipamentoLocacaoAcessorio;

    function getObjEquAce: TEquipamentoLocacaoAcessorio;
  public
    constructor Create;
    destructor Destroy; override;

    function fHerdarCadAceLoc(const strCodAce: String): Boolean;
    property objEquAce: TEquipamentoLocacaoAcessorio read getObjEquAce;
  End;

implementation

uses
  untFuncoesSimples, DateUtils, untFuncoesLocEqu;

{ TEquipamentoLocacaoAcessorio }

constructor TEquipamentoLocacaoAcessorio.Create;
begin
  inherited;

  FItemFracionado := False;
  FSlMensagemTrava := TStringList.Create;
end;

destructor TEquipamentoLocacaoAcessorio.Destroy;
begin
  FreeAndNil(FSlMensagemTrava);

  inherited;
end;

function TEquipamentoLocacaoAcessorio.GetAnoFab: Integer;
begin
  Result := FAnoFab;
end;

function TEquipamentoLocacaoAcessorio.GetAutInc: String;
begin
  Result := FAutInc;
end;

function TEquipamentoLocacaoAcessorio.GetCodigo: String;
begin
  Result := FCodigo;
end;

function TEquipamentoLocacaoAcessorio.GetCodIte: String;
begin
  Result := FCodIte;
end;

function TEquipamentoLocacaoAcessorio.GetCodIteV: Boolean;
begin
  Result := FblnCodigoItemValido;
end;

function TEquipamentoLocacaoAcessorio.GetDatAqu: TDateTime;
begin
  Result := FDatAqu;
end;

function TEquipamentoLocacaoAcessorio.GetDescri: String;
begin
  Result := FDescri;
end;

function TEquipamentoLocacaoAcessorio.GetDesIte: String;
begin
  Result := FDesIte;
end;

function TEquipamentoLocacaoAcessorio.GetDtaVen: TDateTime;
begin
  Result := FDtaVen;
end;

function TEquipamentoLocacaoAcessorio.GetDtUlMn: TDateTime;
begin
  Result := FDtUlMn;
end;

function TEquipamentoLocacaoAcessorio.GetEspecf: String;
begin
  Result := FEspecf;
end;

function TEquipamentoLocacaoAcessorio.GetGarant: Integer;
begin
  Result := FGarant;
end;

function TEquipamentoLocacaoAcessorio.GetIteFra: Boolean;
begin
  Result := FItemFracionado;
end;

function TEquipamentoLocacaoAcessorio.GetLocFis: String;
begin
  Result := FLocFis;
end;

function TEquipamentoLocacaoAcessorio.GetMensagem: String;
begin
  Result := FMensagem;
end;

function TEquipamentoLocacaoAcessorio.GetModelo: String;
begin
  Result := FModelo;
end;

function TEquipamentoLocacaoAcessorio.GetMsgTrv: String;
begin
  Result := FSlMensagemTrava.Text;
end;

function TEquipamentoLocacaoAcessorio.GetNumLot: String;
begin
  Result := FNumLot;
end;

function TEquipamentoLocacaoAcessorio.GetRpUlMn: String;
begin
  Result := FRpUlMn;
end;

function TEquipamentoLocacaoAcessorio.GetStatus: String;
begin
  Result := FStatus;
end;

function TEquipamentoLocacaoAcessorio.GetValAqu: Double;
begin
  Result := FValAqu;
end;

function TEquipamentoLocacaoAcessorio.GetVlrAqu: Double;
begin
  Result := FVlrAqu;
end;

function TEquipamentoLocacaoAcessorio.GetVlrCau: Double;
begin
  Result := FVlrCau;
end;

function TEquipamentoLocacaoAcessorio.GetVlrdAdt: Double;
begin
  Result := FVlrAdc;
end;

class procedure TEquipamentoLocacaoAcessorio.pAtivarAcessorio(const strAutInc: String);
var
  qryUpdate: TUniQuery;
begin
  qryUpdate := fCriaQuery;
  Try
    qryUpdate.DisableControls;
    qryUpdate.SQL.Add('UPDATE CADACL SET ACL_STATUS = "A", ACL_DTALIB = :DTALIB, ACL_HRALIB = :HRALIB, ACL_OPELIB = :OPELIB WHERE AUTOINCREM = :AUTINC');
    qryUpdate.ParamByName('AUTINC').AsString := strAutInc;
    qryUpdate.ParamByName('DTALIB').AsDateTime := Today;
    qryUpdate.ParamByName('HRALIB').AsDateTime := fNow();
    qryUpdate.ParamByName('OPELIB').AsString := strLoginUsuarioLogado;
    qryUpdate.ExecSQL;
  Finally
    FreeAndNil(qryUpdate);
  End;
end;

procedure TEquipamentoLocacaoAcessorio.pCarregaEquipamento(
  const strAutInc: String = ''; const strCodAcl: String = '');
var
  qry: TUniQuery;
  srtSQLSelect: String;
  objCadLot: TCadLot;
begin
  qry := fCriaQuery();
  objCadLot := TCadLot.Create(Nil);
  Try
    qry.DisableControls;
    srtSQLSelect := 'SELECT  CADACL.AUTOINCREM, ' +
                        'ACL_CODIGO, ' +
                        'ACL_DESCRI, ' +
                        'ACL_DTAAQU, ' +
                        'ACL_VALAQU, ' +
                        'ACL_GARANT, ' +
                        'ACL_DTULMN, ' +
                        'ACL_RPULMN, ' +
                        'ACL_MODELO, ' +
                        'ACL_ANOFAB, ' +
                        'ACL_ESPECF, ' +
                        'ACL_LOCFIS, ' +
                        'ACL_CODITE, ' +
                        'ACL_DTAVEN, ' +
                        'ACL_STATUS, ' +
                        'ITE_DESITE, ' +
                        'ACL_VLRCAU, ' +
                        'ACL_VLRADC  ' +
                    ' FROM CADACL    ' +
                    ' INNER JOIN CADITE ON (ITE_CODITE = ACL_CODITE) ' +
                    '  WHERE TRUE';

    If Not fEmptyStr(strAutInc) Then
      srtSQLSelect := srtSQLSelect +  ' AND CADACL.AUTOINCREM = :AUTOINCREM ';

    If Not fEmptyStr(strCodAcl) Then
      srtSQLSelect := srtSQLSelect +  ' AND CADACL.ACL_CODIGO = :ACL_CODIGO ';

    qry.SQl.Add(srtSQLSelect);

    If qry.Params.FindParam('AUTOINCREM') <> Nil Then
      qry.ParamByName('AUTOINCREM').AsString := strAutInc;
    If qry.Params.FindParam('ACL_CODIGO') <> Nil Then
      qry.ParamByName('ACL_CODIGO').AsString := strCodAcl;

    qry.Open;
    If Not(qry.IsEmpty) Then
    Begin
      FAutInc := qry.FieldByName('AUTOINCREM').AsString;
      FCodigo := qry.FieldByName('ACL_CODIGO').AsString;
      FDescri := qry.FieldByName('ACL_DESCRI').AsString;
      FDatAqu := qry.FieldByName('ACL_DTAAQU').AsDateTime;
      FValAqu := qry.FieldByName('ACL_VALAQU').AsFloat;
      FGarant := qry.FieldByName('ACL_GARANT').AsInteger;
      FDtUlMn := qry.FieldByName('ACL_DTULMN').AsDateTime;
      FRpUlMn := qry.FieldByName('ACL_RPULMN').AsString;
      FModelo := qry.FieldByName('ACL_MODELO').AsString;
      FAnoFab := qry.FieldByName('ACL_ANOFAB').AsInteger;
      FEspecf := qry.FieldByName('ACL_ESPECF').AsString;
      FLocFis := qry.FieldByName('ACL_LOCFIS').AsString;
      FCodIte := qry.FieldByName('ACL_CODITE').AsString;
      FDtaVen := qry.FieldByName('ACL_DTAVEN').AsDateTime;
      FStatus := qry.FieldByName('ACL_STATUS').AsString;
      FDesIte := qry.FieldByName('ITE_DESITE').AsString;
      FVlrCau := qry.FieldByName('ACL_VLRCAU').AsFloat;
      FVlrAdc := qry.FieldByName('ACL_VLRADC').AsFloat;

      If ((objCadLot.tplTipLot = tplArmazem) And (fEmptyStr(FNumLot))) Then
      Begin
        FNumLot := objCadLot.fRetArmazemPrincipalLocacaoDeEquipamento(FCodIte);
      End;

    End;
  Finally
    qry.Close;
    FreeAndNil(qry);
    FreeAndNil(objCadLot);
  End;
end;

procedure TEquipamentoLocacaoAcessorio.pLimpar;
begin
  FAnoFab := 0;
  FAutInc := EmptyStr;
  FCodigo := EmptyStr;
  FCodIte := EmptyStr;
  FDesIte := EmptyStr;
  FDatAqu := 0;
  FDescri := EmptyStr;
  FDtaVen := 0;
  FDtUlMn := 0;
  FEspecf := EmptyStr;
  FGarant := 0;
  FLocFis := EmptyStr;
  FModelo := EmptyStr;
  FRpUlMn := EmptyStr;
  FStatus := EmptyStr;
  FValAqu := 0;
  FMensagem := EmptyStr;
  FItemFracionado := False;
  FBlnTrv := False;
  FNumLot := EmptyStr;
  FSlMensagemTrava.Clear;
  FblnCodigoItemValido := False;
  FVlrAdc := 0;
end;

procedure TEquipamentoLocacaoAcessorio.SetAnoFab(const AValue: Integer);
begin
  FAnoFab := AValue;
end;

procedure TEquipamentoLocacaoAcessorio.SetAutInc(const AValue: String);
begin
  FAutInc := AValue;
end;

procedure TEquipamentoLocacaoAcessorio.SetCodigo(const AValue: String);
begin
  FCodigo := AValue;
end;

procedure TEquipamentoLocacaoAcessorio.SetCodIte(const AValue: String);
begin
  FCodIte := AValue;
end;

procedure TEquipamentoLocacaoAcessorio.SetDatAqu(const AValue: TDateTime);
begin
  FDatAqu := AValue;
end;

procedure TEquipamentoLocacaoAcessorio.SetDescri(const AValue: String);
begin
  FDescri := AValue;
end;

procedure TEquipamentoLocacaoAcessorio.SetDesIte(const AValue: String);
begin
  FDesIte := AValue;
end;

procedure TEquipamentoLocacaoAcessorio.SetDtaven(const AValue: TDateTime);
begin
  FDtaVen := AValue;
end;

procedure TEquipamentoLocacaoAcessorio.SetDtUlMn(const AValue: TDateTime);
begin
  FDtUlMn := AValue;
end;

procedure TEquipamentoLocacaoAcessorio.SetEspecf(const AValue: String);
begin
  FEspecf := AValue;
end;

procedure TEquipamentoLocacaoAcessorio.SetGarant(const AValue: Integer);
begin
  FGarant := AValue;
end;

procedure TEquipamentoLocacaoAcessorio.SetIteFra(const AValue: Boolean);
begin
  FItemFracionado := AValue;
end;

procedure TEquipamentoLocacaoAcessorio.SetLocFis(const AValue: String);
begin
  FLocFis := AValue;
end;

procedure TEquipamentoLocacaoAcessorio.SetMensagem(const AValue: String);
begin
  FMensagem := AValue;
end;

procedure TEquipamentoLocacaoAcessorio.SetModelo(const AValue: String);
begin
  FModelo := AValue;
end;

procedure TEquipamentoLocacaoAcessorio.SetNumLot(const AValue: String);
begin
  FNumLot := AValue;
end;

procedure TEquipamentoLocacaoAcessorio.SetRpUlMn(const AValue: String);
begin
  FRpUlMn := AValue;
end;

procedure TEquipamentoLocacaoAcessorio.SetStatus(const AValue: String);
begin
  FStatus := AValue;
end;

procedure TEquipamentoLocacaoAcessorio.SetValAqu(const AValue: Double);
begin
  FValAqu := AValue;
end;

procedure TEquipamentoLocacaoAcessorio.SetVlrAdc(const AValue: Double);
begin
  FVlrAdc := AValue;
end;

procedure TEquipamentoLocacaoAcessorio.SetVlrAqu(const AValue: Double);
begin
  FVlrAqu := AValue;
end;

procedure TEquipamentoLocacaoAcessorio.SetVlrCau(const Value: Double);
begin
  FVlrCau := Value;
end;

function TEquipamentoLocacaoAcessorio.fCarregaAcessorio(
  const strCodAcl: String): Boolean;
var
  qry: TUniQuery;
  PrecoContrato: TPrecoContrato;
  intDecUni: Integer;
begin
  Result := False;

  If fEmptyStr(strCodAcl) Then
  Begin
    Exit;
  End;

  PrecoContrato :=  TPrecoContrato(fCfgSis('PRECTR', varInteger));
  intDecUni := fCfgSis('DECUNI', VarInteger);

  qry := fCriaQuery();
  Try
    qry.DisableControls;
    qry.SQl.Add('SELECT  CADACL.AUTOINCREM, ' +
                '        ACL_CODIGO,        ' +
                '        ACL_DESCRI,        ' +
                '        ACL_DTAAQU,        ' +
                '        ACL_VALAQU,        ' +
                '        ACL_GARANT,        ' +
                '        ACL_DTULMN,        ' +
                '        ACL_RPULMN,        ' +
                '        ACL_MODELO,        ' +
                '        ACL_ANOFAB,        ' +
                '        ACL_ESPECF,        ' +
                '        ACL_LOCFIS,        ' +
                '        ACL_CODITE,        ' +
                '        ACL_DTAVEN,        ' +
                '        ACL_STATUS,        ' +
                '        I.ITE_DESITE,      ' +
                '        UNI_ITEFRA,        ' +
                '        G.ITE_PREVE1,      ' +
                '        G.ITE_PREVE2,      ' +
                '        G.ITE_PREVE3,      ' +
                '        G.ITE_PREVE4,      ' +
                '        G.ITE_PREVE5,      ' +
                '        G.ITE_PREVE6,      ' +
                '        G.ITE_PREVE7,      ' +
                '        G.ITE_PRECUS,      ' +
                '        G.ITE_PREMED,      ' +
                '        G.ITE_PRECOM,      ' +
                '        G.ITE_DESF01,      ' +
                '        G.ITE_DESF02,      ' +
                '        G.ITE_DESF03,      ' +
                '        G.ITE_DESF04,      ' +
                '        G.ITE_DESF05,      ' +
                '        G.ITE_DESF06,      ' +
                '        ACL_VLRCAU,        ' +
                '        ACL_VLRADC         ' +
                ' FROM CADACL               ' +
                ' INNER JOIN CADITE I ON (I.ITE_CODITE = ACL_CODITE) ' +
                ' INNER JOIN CADUNI   ON (UNI_CODUNI = I.ITE_CODUNI) ' +
                ' INNER JOIN ITEGER G ON (I.ITE_CODITE = G.ITE_CODITE ) ' +
                '  WHERE ACL_CODIGO = :ACL_CODIGO' +
                '  AND G.ITE_CODEMP = :ITE_CODEMP');
    qry.ParamByName('ACL_CODIGO').AsString := strCodAcl;
    qry.ParamByName('ITE_CODEMP').AsString := VS_strCodEmp;
    qry.Open;
    If Not(qry.IsEmpty) Then
    Begin
      FAutInc := qry.FieldByName('AUTOINCREM').AsString;
      FCodigo := qry.FieldByName('ACL_CODIGO').AsString;
      FDescri := qry.FieldByName('ACL_DESCRI').AsString;
      FDatAqu := qry.FieldByName('ACL_DTAAQU').AsDateTime;
      FValAqu := qry.FieldByName('ACL_VALAQU').AsFloat;
      FGarant := qry.FieldByName('ACL_GARANT').AsInteger;
      FDtUlMn := qry.FieldByName('ACL_DTULMN').AsDateTime;
      FRpUlMn := qry.FieldByName('ACL_RPULMN').AsString;
      FModelo := qry.FieldByName('ACL_MODELO').AsString;
      FAnoFab := qry.FieldByName('ACL_ANOFAB').AsInteger;
      FEspecf := qry.FieldByName('ACL_ESPECF').AsString;
      FLocFis := qry.FieldByName('ACL_LOCFIS').AsString;
      FCodIte := qry.FieldByName('ACL_CODITE').AsString;
      FDtaVen := qry.FieldByName('ACL_DTAVEN').AsDateTime;
      FStatus := qry.FieldByName('ACL_STATUS').AsString;
      FDesIte := qry.FieldByName('ITE_DESITE').AsString;
      FItemFracionado := qry.FieldByName('UNI_ITEFRA').AsString = 'S';
      Case PrecoContrato of
        preCompraLiq: Begin
                        FVlrAqu := untfuncoesSimples.fCalculaPrecoCompraLiq(qry.FieldByName('ITE_PRECOM').AsFloat,
                                                                            qry.FieldByName('ITE_DESF01').AsFloat,
                                                                            qry.FieldByName('ITE_DESF02').AsFloat,
                                                                            qry.FieldByName('ITE_DESF03').AsFloat,
                                                                            qry.FieldByName('ITE_DESF04').AsFloat,
                                                                            qry.FieldByName('ITE_DESF05').AsFloat,
                                                                            qry.FieldByName('ITE_DESF06').AsFloat,
                                                                            intDecUni);
                      End;
        preCusto    : FVlrAqu := qry.FieldByName('ITE_PRECUS').AsFloat;
        preMedio    : FVlrAqu := qry.FieldByName('ITE_PREMED').AsFloat;
        preTabela1  : FVlrAqu := qry.FieldByName('ITE_PREVE1').AsFloat;
        preTabela2  : FVlrAqu := qry.FieldByName('ITE_PREVE2').AsFloat;
        preTabela3  : FVlrAqu := qry.FieldByName('ITE_PREVE3').AsFloat;
        preTabela4  : FVlrAqu := qry.FieldByName('ITE_PREVE4').AsFloat;
        preTabela5  : FVlrAqu := qry.FieldByName('ITE_PREVE5').AsFloat;
        preTabela6  : FVlrAqu := qry.FieldByName('ITE_PREVE6').AsFloat;
        preTabela7  : FVlrAqu := qry.FieldByName('ITE_PREVE7').AsFloat;
        preCaucao   : FVlrAqu := qry.FieldByName('ACL_VLRCAU').AsFloat
        Else
          FVlrAqu := qry.FieldByName('ITE_PRECUS').AsFloat;
      End;
      FVlrCau := qry.FieldByName('ACL_VLRCAU').AsFloat;

      If qry.FieldByName('ACL_STATUS').AsString = 'I' Then
      Begin
        FMensagem := 'Acessório Inativo';
        Result := False;
      End
      Else If qry.FieldByName('ACL_STATUS').AsString = 'B' Then
      Begin
        FMensagem := 'Acessório Bloqueado';
        Result := False;
      End
      Else
        Result := True;

      FVlrAdc := qry.FieldByName('ACL_VLRADC').AsFloat;
    End;
  Finally
    qry.Close;
    FreeAndNil(qry);
  End;
end;

function TEquipamentoLocacaoAcessorio.fValidaAcessorio(blnListarTodos: Boolean = False): Boolean;
begin
  FBlnTrv := False;
  FSlMensagemTrava.Clear;
  FMensagem := EmptyStr;

  If FStatus = 'I' Then
  Begin
    FBlnTrv := True;
    FMensagem := 'Acessório Inativo.';
    FSlMensagemTrava.Add(FMensagem);
    Result := False;
    Exit;
  End;

  If FStatus = 'B' Then
  Begin
    FBlnTrv := True;
    FMensagem := 'Acessório Bloqueado.';
    FSlMensagemTrava.Add(FMensagem);
    Result := False;
    Exit;
  End;

  Result := fValidaItemLocacao(FCodIte, blnListarTodos);
end;

function TEquipamentoLocacaoAcessorio.fValidaItemLocacao(strCodIte: String; blnListarTodos: Boolean = False): Boolean;
var
  qryConsulta: TUniQuery;
begin
  FblnCodigoItemValido := True;
  Result := True;
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.DisableControls;
    Try
      qryConsulta.SQL.Add('SELECT I.ITE_TIPLOC, I.ITE_REALOC, I.ITE_ITEATI, G.ITE_IMPLIS,');
      qryConsulta.SQL.Add('       I.ITE_CODITE, I.ITE_DESITE   ');
      qryConsulta.SQL.Add('  FROM CADITE I');
      qryConsulta.SQL.Add('   INNER JOIN ITEGER G              ');
      qryConsulta.SQL.Add('     ON I.ITE_CODITE = G.ITE_CODITE ');
      qryConsulta.SQL.Add(' WHERE I.ITE_CODITE = :CODITE');
      qryConsulta.SQL.Add('   AND G.ITE_CODEMP = :CODEMP');
      qryConsulta.ParamByName('CODITE').AsString := strCodIte;
      qryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;

      qryConsulta.Open;
      If (qryConsulta.isEmpty) Then
      Begin
        Result := False;
        FMensagem := 'Item não localizado.';
        Exit;
      End;

      If qryConsulta.FieldByName('ITE_ITEATI').AsString = 'N' Then
      Begin
        FBlnTrv := True;
        Result := False;
        FMensagem := 'Este item não está ativo.';
        FSlMensagemTrava.Add(FMensagem);
        FSlMensagemTrava.Add('');
        If Not blnListarTodos Then
          Exit;
      End;

      If Not fValidarItemEhAcessorioLocacao(qryConsulta.FieldByName('ITE_IMPLIS').AsString,
                                            qryConsulta.FieldByName('ITE_REALOC').AsString,
                                            qryConsulta.FieldByName('ITE_TIPLOC').AsString,
                                            blnListarTodos) Then
      Begin
        Result := False;
        FBlnTrv := True;
        If Not blnListarTodos Then
          Exit;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fValidaItemEquipamentoLocacao]');
      End;
    End;
  Finally
    FblnCodigoItemValido := Result;
    qryConsulta.Close;
    FreeAndNil(qryConsulta);
  End
end;

function TEquipamentoLocacaoAcessorio.fValidarItemEhAcessorioLocacao(
  const strImpLst, strRealoc, strTipLoc: String;
  blnListarTodos: Boolean): Boolean;
begin
  Result := True;

  If strImpLst = 'N' Then
  Begin
    FBlnTrv := True;
    Result := False;
    FMensagem := 'Este item setá setado como "Imprime Lista = Não" e não pode ser vinculado ao equipamento."';
    FSlMensagemTrava.Add(FMensagem);
    FSlMensagemTrava.Add('');
    If Not blnListarTodos Then
      Exit;
  End;

  If Not (strRealoc = 'S') Then
  Begin
    FBlnTrv := True;
    Result := False;
    FMensagem := 'Este item está configurado em seu cadastro para não realizar locação e por isto, não pode ser vinculado ao equipamento."';
    FSlMensagemTrava.Add(FMensagem);
    FSlMensagemTrava.Add('');
    If Not blnListarTodos Then
      Exit;
  End;

  If strTipLoc = 'P' Then
  Begin
    FBlnTrv := True;
    Result := False;
    FMensagem := 'Este item está configurado em seu cadastro como produto principal para locação e não como um acessório. '+
                 'Sendo assim, não é permitido vincular o item ao cadastro. Se for necessário, realize o ajuste e depois tente novamente.';
    FSlMensagemTrava.Add(FMensagem);
    FSlMensagemTrava.Add('');
    If Not blnListarTodos Then
      Exit;
  End;

end;

function TEquipamentoLocacaoAcessorio.fValidaQuantidadeItemFracionado(const aQtd: Double): Boolean;
var
  aux: Double;
begin
  Result := True;

  If Not FItemFracionado Then
  Begin
    aux:= Frac(aQtd );
    Result := (aux = 0);

    If Not Result Then
      FMensagem := 'O item não permite informar quantidade fracionada.';
  End;
end;

function TEquipamentoLocacaoAcessorio.fValidarItemAssociadoEquipamento(
  const strCodIte: String): Boolean;
var
  SQLSelectEql: String;
  SQLSelectAcl: String;
  qryConsulta: TUniQuery;
begin

  SQLSelectEql := 'SELECT EQL_CODITE,    ' +
                  '       EQL_CODIGO,    ' +
                  '       EQL_DESCRI,    ' +
                  '       I.ITE_CODITE,  ' +
                  '       I.ITE_DESITE   ' +
                  'FROM CADEQL           ' +
                  ' INNER JOIN CADITE I ON (I.ITE_CODITE = EQL_CODITE)   ' +
                  ' INNER JOIN ITEGER G ON (I.ITE_CODITE = G.ITE_CODITE ) ' +
                  '   WHERE EQL_CODITE = :EQL_CODITE ';

  SQLSelectAcl := 'SELECT ACL_CODITE,    ' +
                  '       ACL_CODIGO,    ' +
                  '       ACL_DESCRI,    ' +
                  '       I.ITE_CODITE,  ' +
                  '       I.ITE_DESITE   ' +
                  'FROM CADACL           ' +
                  ' INNER JOIN CADITE I ON (I.ITE_CODITE = ACL_CODITE)    ' +
                  ' INNER JOIN ITEGER G ON (I.ITE_CODITE = G.ITE_CODITE ) ' +
                  '   WHERE ACL_CODITE = :EQL_CODITE';

  If Not fEmptyStr(FCodigo) Then
    SQLSelectAcl := SQLSelectAcl + '   AND   ACL_CODIGO <> :ACL_CODIGO ';

  qryConsulta := fCriaQuery;
  Try
    qryConsulta.DisableControls;
    qryConsulta.SQL.Add(SQLSelectEql);
    qryConsulta.ParamByName('EQL_CODITE').AsString := strCodIte;
    qryConsulta.Open;

    Result := qryConsulta.IsEmpty;
    If Result Then
    Begin
      qryConsulta.SQL.Clear;
      qryConsulta.SQL.Add(SQLSelectAcl);
      qryConsulta.ParamByName('EQL_CODITE').AsString := strCodIte;
      If Not fEmptyStr(FCodigo) Then
        qryConsulta.ParamByName('ACL_CODIGO').AsString := FCodigo;
      qryConsulta.Open;

      Result := qryConsulta.IsEmpty;

      If Not Result Then
        FMensagem := 'O item "' + qryConsulta.FieldByName('ITE_CODITE').AsString + ' - ' + qryConsulta.FieldByName('ITE_DESITE').AsString + '"' +
                     ' já está associado ao acessório "' + qryConsulta.FieldByName('ACL_CODIGO').AsString + ' - ' + qryConsulta.FieldByName('ACL_DESCRI').AsString + '". ' +
                     'Não é permitido associar o mesmo item em dois equipamentos diferentes!';
    End
    Else
    Begin
      FMensagem := 'O item "' + qryConsulta.FieldByName('ITE_CODITE').AsString + ' - ' + qryConsulta.FieldByName('ITE_DESITE').AsString + '"' +
                   ' já está associado ao equipamento "' + qryConsulta.FieldByName('EQL_CODIGO').AsString + ' - ' + qryConsulta.FieldByName('EQL_DESCRI').AsString + '". ' +
                   'Não é permitido associar o mesmo item em dois equipamentos diferentes!';
    End;
  Finally
    qryConsulta.Close;
    FreeAndNil(qryConsulta);
  End;
end;

{ THerancaCadAceLoc }

constructor THerancaCadAceLoc.Create;
begin
  FobjEquAce := TEquipamentoLocacaoAcessorio.Create;
end;

destructor THerancaCadAceLoc.Destroy;
begin

  inherited;

  FreeAndNil(FobjEquAce);
end;

function THerancaCadAceLoc.fHerdarCadAceLoc(const strCodAce: String): Boolean;
begin
  If fEmptyStr(strCodAce) Then
    Exit(False);

  Try
    FobjEquAce.pCarregaEquipamento ('', strCodAce);
    FobjEquAce.DataVenda := 0;
    FobjEquAce.Codigo := EmptyStr;
    FobjEquAce.AutInc := EmptyStr;

    Result := True;
  Except
    Result := False;
  End;
end;

function THerancaCadAceLoc.getObjEquAce: TEquipamentoLocacaoAcessorio;
begin
  Result := FobjEquAce;
end;

end.
