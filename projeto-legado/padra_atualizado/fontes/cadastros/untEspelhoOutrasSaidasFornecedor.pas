unit untEspelhoOutrasSaidasFornecedor;

interface

Uses System.SysUtils, Uni, untFuncoesSimples, Data.DB, untFuncFatTypes;

Type
  TEspelhoChaveReferenciada = class
  private
    procedure pDeleta(const strIncEspGer : String);
  public
    procedure pSalva(const strIncEspGer : String; const arrChaves: TArrChaveNFReferenciaDocumentos);
    procedure pCarregaRegistro(const strIncEspGer : String; var arrChaves: TArrChaveNFReferenciaDocumentos);
  End;

  TEspelhoDetalhe = Class
  Private
    FAutInc : String;
    FSeqGer : String;
    FCodIte : String;
    FQtdIte : Double;
    FUnitar : Double;
    FCodFis : String;
    FCodAbf : String;
    FTotIte : Double;
    FBasIcm : Double;
    FAlqIcm : Double;
    FValIcm : Double;
    FBasIpi : Double;
    FAlqIpi : Double;
    FValIpi : Double;
    FBasRet : Double;
    FValRet : Double;
    FValCbs : Double;
    FValIbs : Double;
    FVal_Is : Double;
    FBasPis : Double;
    FAlqPis : Double;
    FValPis : Double;
    FCstPis : String;
    FBasCoF : Double;
    FAlqCof : Double;
    FValCof : Double;
    FCstCof : String;
    FClaFis : String;
    FBasVrd : Double;
    FVrdIcm : Double;
    FMtdIcm : String;
    FSeqDet : String;
    FDescon : Double;
    FDesEsp : Double;
    FUniOri : Double;
    FUniDig : Double;
    FIncPis : String;
    FQtdExp : Double;
    FBasFcp : Double;
    FPerFcp : Double;
    FValFcp : Double;
    FBFcpST : Double;
    FPFcpST : Double;
    FVFcpST : Double;
    FDocDev : String;
    FEspDev : String;
    FEmpDev : String;
    FstrNumeroDoLote : String;
    FDesAce : Double;
    FVlrCon : Double;
    FTotFre : Double;
    FVal_Rt : Double;
    FPebaST : Double;
    FNr_Pis : String;
    FNr_Cof : String;
    FDesIte : String;
    FDesNes : String;
    FValIva : Double;
    FPerRed : Double;
    FAlqRet : Double;

  Public
    Property strAutInc       : String Read FAutInc          Write FAutInc;
    Property strSeqGer       : String Read FSeqGer          Write FSeqGer;
    Property strCodIte       : String Read FCodIte          Write FCodIte;
    Property fltQtdIte       : Double Read FQtdIte          Write FQtdIte;
    Property fltUnitar       : Double Read FUnitar          Write FUnitar;
    Property strCodFis       : String Read FCodFis          Write FCodFis;
    Property strCodAbf       : String Read FCodAbf          Write FCodAbf;
    Property fltTotIte       : Double Read FTotIte          Write FTotIte;
    Property fltBasIcm       : Double Read FBasIcm          Write FBasIcm;
    Property fltAlqIcm       : Double Read FAlqIcm          Write FAlqIcm;
    Property fltValIcm       : Double Read FValIcm          Write FValIcm;
    Property fltBasIpi       : Double Read FBasIpi          Write FBasIpi;
    Property fltAlqIpi       : Double Read FAlqIpi          Write FAlqIpi;
    Property fltValIpi       : Double Read FValIpi          Write FValIpi;
    Property fltBasRet       : Double Read FBasRet          Write FBasRet;
    Property fltValRet       : Double Read FValRet          Write FValRet;
    Property fltValCBS       : Double Read FValCbs          Write FValCbs;
    Property fltValIBS       : Double Read FValIbs          Write FValIbs;
    Property fltVal_IS       : Double Read FVal_Is          Write FVal_Is;
    Property fltBasPis       : Double Read FBasPis          Write FBasPis;
    Property fltAlqPis       : Double Read FAlqPis          Write FAlqPis;
    Property fltValPis       : Double Read FValPis          Write FValPis;
    Property strCstPis       : String Read FCstPis          Write FCstPis;
    Property fltBasCoF       : Double Read FBasCoF          Write FBasCoF;
    Property fltAlqCof       : Double Read FAlqCof          Write FAlqCof;
    Property fltValCof       : Double Read FValCof          Write FValCof;
    Property strCstCof       : String Read FCstCof          Write FCstCof;
    Property strClaFis       : String Read FClaFis          Write FClaFis;
    Property fltBasVrd       : Double Read FBasVrd          Write FBasVrd;
    Property fltVrdIcm       : Double Read FVrdIcm          Write FVrdIcm;
    Property strMtdIcm       : String Read FMtdIcm          Write FMtdIcm;
    Property strSeqDet       : String Read FSeqDet          Write FSeqDet;
    Property fltDescon       : Double Read FDescon          Write FDescon;
    Property fltDesEsp       : Double Read FDesEsp          Write FDesEsp;
    Property fltUniOri       : Double Read FUniOri          Write FUniOri;
    Property fltUniDig       : Double Read FUniDig          Write FUniDig;
    Property strIncPis       : String Read FIncPis          Write FIncPis;
    Property fltQtdExp       : Double Read FQtdExp          Write FQtdExp;
    Property fltBasFcp       : Double Read FBasFcp          Write FBasFcp;
    Property fltPerFcp       : Double Read FPerFcp          Write FPerFcp;
    Property fltValFcp       : Double Read FValFcp          Write FValFcp;
    Property fltBFcpST       : Double Read FBFcpST          Write FBFcpST;
    Property fltPFcpST       : Double Read FPFcpST          Write FPFcpST;
    Property fltVFcpST       : Double Read FVFcpST          Write FVFcpST;
    Property strDocDev       : String Read FDocDev          Write FDocDev;
    Property strEspDev       : String Read FEspDev          Write FEspDev;
    Property strEmpDev       : String Read FEmpDev          Write FEmpDev;
    property fltDesAce       : Double Read FDesAce          Write FDesAce;
    property fltVlrCon       : Double Read FVlrCon          Write FVlrCon;
    property fltTotFre       : Double Read FTotFre          Write FTotFre;
    property fltVal_Rt       : Double Read FVal_Rt          Write FVal_Rt;
    property fltValIva       : Double Read FValIva          Write FValIva;
    property fltPerRed       : Double Read FPerRed          Write FPerRed;
    property fltAlqRet       : Double Read FAlqRet          Write FAlqRet;
    property fltPebaST       : Double Read FPebaST          Write FPebaST;
    property strNr_Pis       : String Read FNr_Pis          Write FNr_Pis;
    property strNr_Cof       : String Read FNr_Cof          Write FNr_Cof;

    Property strNumeroDoLote : String Read FstrNumeroDoLote Write FstrNumeroDoLote;
    Property strDesIte       : String Read FDesIte          Write FDesIte;
    Property strDesNes       : String Read FDesNes          Write FDesNes;

    function fSalva : Boolean;
    function fCarregaRegistro(strAutInc : String) : Boolean;
    class function fZerarContagem(strSeqGer : String):Boolean;
    Constructor Create;
  End;

  TEspelhoCapa = Class
  private
    FAutInc : String;
    FCodEmp : String;
    FNumEsp : String;
    FCodFor : String;
    FCodCli : String;
    FTip_FC : String;
    FCodAde : String;
    FClaFis : String;
    FTotPro : Double;
    FTotIpi : Double;
    FTotRet : Double;
    FTotCbs : Double;
    FTotIbs : Double;
    FTot_Is : Double;
    FTotFre : Double;
    FDesAce : Double;
    FVlrCon : Double;
    FQtdIte : Integer;
    FMovGer : String;
    FConPag : String;
    FCodCnd : String;
    FCodFpg : String;
    FVPar01 : Double;
    FVPar02 : Double;
    FVPar03 : Double;
    FVPar04 : Double;
    FVPar05 : Double;
    FVPar06 : Double;
    FVPar07 : Double;
    FVPar08 : Double;
    FVPar09 : Double;
    FVPar10 : Double;
    FVPar11 : Double;
    FVPar12 : Double;
    FCnfNfe : String;
    FCodTra : String;
    FBasIPI : Double;
    FAlqIPI : Double;
    FBasIcm : Double;
    FAlqICM : Double;
    FTotICM : Double;
    FAlqRet : Double;
    FBasRet : Double;
    FBasFcpST : Double;
    FAlqFcpST : Double;
    FTotFcpST : Double;
    FDesEsp : Double;
    FTipFre : String;
    FPesBru : Double;
    FPesLiq : Double;
    FVolume : Double;
    FEspeci : String;
    FMarca_ : String;
    FNumera : String;
    FOpeExp : String;
    FDtaExp : TDateTime;
    FHraExp : TDateTime;
    FMen001 : String;
    FMen002 : String;
    FMen003 : String;
    FMen004 : String;
    FMen005 : String;
    FChvNFE : String;
    FNatOpe : String;
    FPlaFat : String;
    FNumRem : String;
  Public
    Property strAutInc : String    Read FAutInc   Write FAutInc;
    Property strCodEmp : String    Read FCodEmp   Write FCodEmp;
    Property strNumEsp : String    Read FNumEsp   Write FNumEsp;
    Property strCodFor : String    Read FCodFor   Write FCodFor;
    Property strCodCli : String    Read FCodCli   Write FCodCli;
    Property strTip_FC : String    Read FTip_FC   Write FTip_FC;
    Property strCodAde : String    Read FCodAde   Write FCodAde;
    Property strClaFis : String    Read FClaFis   Write FClaFis;
    Property fltTotPro : Double    Read FTotPro   Write FTotPro;
    Property fltTotIpi : Double    Read FTotIpi   Write FTotIpi;
    Property fltTotRet : Double    Read FTotRet   Write FTotRet;
    Property fltTotCBS : Double    Read FTotCbs   Write FTotCbs;
    Property fltTotIBS : Double    Read FTotIbs   Write FTotIbs;
    Property fltTotIS  : Double    Read FTot_Is   Write FTot_Is;
    Property fltTotFre : Double    Read FTotFre   Write FTotFre;
    Property fltDesAce : Double    Read FDesAce   Write FDesAce;
    Property fltVlrCon : Double    Read FVlrCon   Write FVlrCon;
    Property intQtdIte : Integer   Read FQtdIte   Write FQtdIte;
    Property strMovGer : String    Read FMovGer   Write FMovGer;
    Property strConPag : String    Read FConPag   Write FConPag;
    Property strCodCnd : String    Read FCodCnd   Write FCodCnd;
    Property strCodFpg : String    Read FCodFpg   Write FCodFpg;
    Property fltVPar01 : Double    Read FVPar01   Write FVPar01;
    Property fltVPar02 : Double    Read FVPar02   Write FVPar02;
    Property fltVPar03 : Double    Read FVPar03   Write FVPar03;
    Property fltVPar04 : Double    Read FVPar04   Write FVPar04;
    Property fltVPar05 : Double    Read FVPar05   Write FVPar05;
    Property fltVPar06 : Double    Read FVPar06   Write FVPar06;
    Property fltVPar07 : Double    Read FVPar07   Write FVPar07;
    Property fltVPar08 : Double    Read FVPar08   Write FVPar08;
    Property fltVPar09 : Double    Read FVPar09   Write FVPar09;
    Property fltVPar10 : Double    Read FVPar10   Write FVPar10;
    Property fltVPar11 : Double    Read FVPar11   Write FVPar11;
    Property fltVPar12 : Double    Read FVPar12   Write FVPar12;
    Property strCnfNfe : String    Read FCnfNfe   Write FCnfNfe;
    Property strCodTra : String    Read FCodTra   Write FCodTra;
    Property fltBasIPI : Double    Read FBasIPI   Write FBasIPI;
    Property fltAlqIPI : Double    Read FAlqIPI   Write FAlqIPI;
    Property fltBasIcm : Double    Read FBasIcm   Write FBasIcm;
    Property fltAlqICM : Double    Read FAlqICM   Write FAlqICM;
    Property fltTotICM : Double    Read FTotICM   Write FTotICM;
    Property fltAlqRet : Double    Read FAlqRet   Write FAlqRet;
    Property fltBasRet : Double    Read FBasRet   Write FBasRet;
    Property fltBasFcpST : Double  Read FBasFcpST Write FBasFcpST;
    Property fltAlqFcpST : Double  Read FAlqFcpST Write FAlqFcpST;
    Property fltTotFcpST : Double  Read FTotFcpST Write FTotFcpST;
    Property fltDesEsp : Double    Read FDesEsp   Write FDesEsp;
    Property strTipFre : String    Read FTipFre   Write FTipFre;
    Property fltPesBru : Double    Read FPesBru   Write FPesBru;
    Property fltPesLiq : Double    Read FPesLiq   Write FPesLiq;
    Property fltVolume : Double    Read FVolume   Write FVolume;
    Property strEspeci : String    Read FEspeci   Write FEspeci;
    Property strMarca_ : String    Read FMarca_   Write FMarca_;
    Property strNumera : String    Read FNumera   Write FNumera;
    Property strOpeExp : String    Read FOpeExp   Write FOpeExp;
    Property dtaDtaExp : TDateTime Read FDtaExp   Write FDtaExp;
    Property dtaHraExp : TDateTime Read FHraExp   Write FHraExp;
    Property strMen001 : String    Read FMen001   Write FMen001;
    Property strMen002 : String    Read FMen002   Write FMen002;
    Property strMen003 : String    Read FMen003   Write FMen003;
    Property strMen004 : String    Read FMen004   Write FMen004;
    Property strMen005 : String    Read FMen005   Write FMen005;
    Property strChvNFE : String    Read FChvNFE   Write FChvNFE;
    property strNatOpe : String    Read FNatOpe   Write FNatOpe;
    Property strPlaFat : String    Read FPlaFat   Write FPlaFat;
    Property strNumRem : String    Read FNumRem   Write FNumRem;

    function fSalva : Boolean;
    function fCarregaRegistro(strAutInc : String) : Boolean;
    class function fMarcaComoExpedido(strAutInc : String) : Boolean;
    class function fMarcaComoEmitido(strAutInc, strSeqGer : String) : Boolean;
    class function fApagarEspelho(strAutInc, strNomFrm : String) : Boolean;
    class function fReabrirEspelho(strAutInc : String) : Boolean;
    Constructor Create;
  End;

  function fRetornaQuantidadeDevolucaoEmAbertoNoEspelho(strAutDet : String): Double;


implementation

{ TEspelhoCapa }

constructor TEspelhoCapa.Create;
begin
  FAutInc   := '';
  FCodEmp   := '';
  FNumEsp   := '';
  FCodFor   := '';
  FCodCli   := '';
  FTip_FC   := 'F';
  FCodAde   := '';
  FClaFis   := '';
  FTotPro   := 0;
  FTotIpi   := 0;
  FTotRet   := 0;
  FTotCbs   := 0;
  FTotIbs   := 0;
  FTot_Is   := 0;
  FTotFre   := 0;
  FDesAce   := 0;
  FVlrCon   := 0;
  FQtdIte   := 0;
  FMovGer   := '';
  FConPag   := '';
  FCodCnd   := '';
  FCodFpg   := '';
  FVPar01   := 0;
  FVPar02   := 0;
  FVPar03   := 0;
  FVPar04   := 0;
  FVPar05   := 0;
  FVPar06   := 0;
  FVPar07   := 0;
  FVPar08   := 0;
  FVPar09   := 0;
  FVPar10   := 0;
  FVPar11   := 0;
  FVPar12   := 0;
  FCnfNfe   := '';
  FCodTra   := '';
  FBasIPI   := 0;
  FAlqIPI   := 0;
  FBasIcm   := 0;
  FAlqICM   := 0;
  FTotICM   := 0;
  FAlqRet   := 0;
  FBasRet   := 0;
  FBasFcpST := 0;
  FAlqFcpST := 0;
  FTotFcpST := 0;
  FDesEsp   := 0;
  FTipFre   := '';
  FPesBru   := 0;
  FPesLiq   := 0;
  FVolume   := 0;
  FEspeci   := '';
  FMarca_   := '';
  FNumera   := '';
  FOpeExp   := '';
  FDtaExp   := 0;
  FHraExp   := 0;
  FMen001   := '';
  FMen002   := '';
  FMen003   := '';
  FMen004   := '';
  FMen005   := '';
  FPlaFat   := '';
  FNumRem   := '';
end;

class function TEspelhoCapa.fApagarEspelho(strAutInc, strNomFrm: String): Boolean;
  Var
    qryTabela : TUniQuery;
begin
  Try
    qryTabela := fCriaQuery;
    Try
      qryTabela.Close;
      qryTabela.SQL.Clear;
      qryTabela.SQL.Add('SELECT * FROM ESPREF WHERE REF_ESPGER = :SEQGER ');
      qryTabela.ParamByName('SEQGER').AsString := strAutInc;
      qryTabela.Open;

      qryTabela.First;
      While Not qryTabela.Eof Do
      Begin
        fVerificaIntegridade(strNomFrm, 'ESPREF', qryTabela);
        qryTabela.Delete;
      End;

      qryTabela.Close;
      qryTabela.SQL.Clear;
      qryTabela.SQL.Add('SELECT * FROM ESPDET WHERE DET_SEQGER = :SEQGER ');
      qryTabela.ParamByName('SEQGER').AsString := strAutInc;
      qryTabela.Open;

      qryTabela.First;
      While Not qryTabela.Eof Do
      Begin
        fVerificaIntegridade(strNomFrm, 'ESPDET', qryTabela);
        qryTabela.Delete;
      End;

      qryTabela.Close;
      qryTabela.SQL.Clear;
      qryTabela.SQL.Add('SELECT * FROM ESPGER WHERE AUTOINCREM = :SEQGER ');
      qryTabela.ParamByName('SEQGER').AsString := strAutInc;
      qryTabela.Open;

      fVerificaIntegridade(strNomFrm, 'ESPGER', qryTabela);
      qryTabela.Delete;
      qryTabela.Close;
      Result := True;
    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '');
      End;

    End;
  Finally
    FreeAndNil(qryTabela);
  End;

end;

function TEspelhoCapa.fCarregaRegistro(strAutInc: String): Boolean;
  Var
    qryEspGer : TUniQuery;
begin
  Try
    Try
      qryEspGer := fCriaQuery;
      With qryEspGer, SQL Do
      Begin
        Close;
        Clear;
        Add('SELECT * FROM ESPGER WHERE AUTOINCREM = :AUTINC ');
        ParamByName('AUTINC').AsString := strAutInc;
        Open;

        Result := not isEmpty;

        If Result Then
        Begin
          Self.strAutInc   := FieldByName('AUTOINCREM').AsString;
          Self.strCodEmp   := FieldByName('GER_CODEMP').AsString;
          Self.strNumEsp   := FieldByName('GER_NUMESP').AsString;
          Self.strCodFor   := FieldByName('GER_CODFOR').AsString;
          Self.strCodCli   := FieldByName('GER_CODCLI').AsString;
          Self.strTip_FC   := FieldByName('GER_TIP_FC').AsString;
          Self.strCodAde   := FieldByName('GER_CODADE').AsString;
          Self.strClaFis   := FieldByName('GER_CLAFIS').AsString;
          Self.fltTotPro   := FieldByName('GER_TOTPRO').AsFloat;
          Self.fltTotIpi   := FieldByName('GER_TOTIPI').AsFloat;
          Self.fltTotRet   := FieldByName('GER_TOTRET').AsFloat;
          Self.fltTotCBS   := FieldByName('GER_TOTCBS').AsFloat;
          Self.fltTotIBS   := FieldByName('GER_TOTIBS').AsFloat;
          Self.fltTotIS    := FieldByName('GER_TOT_IS').AsFloat;
          Self.fltTotFre   := FieldByName('GER_TOTFRE').AsFloat;
          Self.fltDesAce   := FieldByName('GER_DESACE').AsFloat;
          Self.fltVlrCon   := FieldByName('GER_VLRCON').AsFloat;
          Self.intQtdIte   := FieldByName('GER_QTDITE').AsInteger;
          Self.strMovGer   := FieldByName('GER_MOVGER').AsString;
          Self.strConPag   := FieldByName('GER_CONPAG').AsString;
          Self.strCodCnd   := FieldByName('GER_CODCND').AsString;
          Self.strCodFpg   := FieldByName('GER_CODFPG').AsString;
          Self.fltVPar01   := FieldByName('GER_VPAR01').AsFloat;
          Self.fltVPar02   := FieldByName('GER_VPAR02').AsFloat;
          Self.fltVPar03   := FieldByName('GER_VPAR03').AsFloat;
          Self.fltVPar04   := FieldByName('GER_VPAR04').AsFloat;
          Self.fltVPar05   := FieldByName('GER_VPAR05').AsFloat;
          Self.fltVPar06   := FieldByName('GER_VPAR06').AsFloat;
          Self.fltVPar07   := FieldByName('GER_VPAR07').AsFloat;
          Self.fltVPar08   := FieldByName('GER_VPAR08').AsFloat;
          Self.fltVPar09   := FieldByName('GER_VPAR09').AsFloat;
          Self.fltVPar10   := FieldByName('GER_VPAR10').AsFloat;
          Self.fltVPar11   := FieldByName('GER_VPAR11').AsFloat;
          Self.fltVPar12   := FieldByName('GER_VPAR12').AsFloat;
          Self.strCnfNfe   := FieldByName('GER_CNFNFE').AsString;
          Self.strCodTra   := FieldByName('GER_CODTRA').AsString;
          Self.fltBasIPI   := FieldByName('GER_BASIPI').AsFloat;
          Self.fltAlqIPI   := FieldByName('GER_ALQIPI').AsFloat;
          Self.fltBasIcm   := FieldByName('GER_BASICM').AsFloat;
          Self.fltAlqICM   := FieldByName('GER_ALQICM').AsFloat;
          Self.fltTotICM   := FieldByName('GER_TOTICM').AsFloat;
          Self.fltAlqRet   := FieldByName('GER_ALQRET').AsFloat;
          Self.fltBasRet   := FieldByName('GER_BASRET').AsFloat;
          Self.fltBasFcpST := FieldByName('GER_BASFCP').AsFloat;
          Self.fltAlqFcpST := FieldByName('GER_ALQFCP').AsFloat;
          Self.fltTotFcpST := FieldByName('GER_TOTFCP').AsFloat;
          Self.fltDesEsp   := FieldByName('GER_DESESP').AsFloat;
          Self.strTipFre   := FieldByName('GER_TIPFRE').AsString;
          Self.fltPesBru   := FieldByName('GER_PESBRU').AsFloat;
          Self.fltPesLiq   := FieldByName('GER_PESLIQ').AsFloat;
          Self.fltVolume   := FieldByName('GER_VOLUME').AsFloat;
          Self.strEspeci   := FieldByName('GER_ESPECI').AsString;
          Self.strMarca_   := FieldByName('GER_MARCA_').AsString;
          Self.strNumera   := FieldByName('GER_NUMERA').AsString;
          Self.strOpeExp   := FieldByName('GER_OPEEXP').AsString;
          Self.dtaDtaExp   := FieldByName('GER_DTAEXP').AsDateTime;
          Self.dtaHraExp   := FieldByName('GER_HRAEXP').AsDateTime;
          Self.strMen001   := FieldByName('GER_MEN001').AsString;
          Self.strMen002   := FieldByName('GER_MEN002').AsString;
          Self.strMen003   := FieldByName('GER_MEN003').AsString;
          Self.strMen004   := FieldByName('GER_MEN004').AsString;
          Self.strMen005   := FieldByName('GER_MEN005').AsString;
          Self.strChvNFE   := FieldByName('GER_CHVNFE').AsString;
          Self.strNatOpe   := FieldByName('GER_NATOPE').AsString;
          Self.strNumRem   := FieldByName('GER_NUMREM').AsString;
          Self.strPlaFat   := FieldByName('GER_PLAFAT').AsString;
        End;

      End;

    Finally
      FreeAndNil(qryEspGer);
    End;

  Except
    On E : Exception Do
    Begin
      pMensagensErro(E.Message, '');
      Result := False;
    End;
  End;

end;

class function TEspelhoCapa.fMarcaComoEmitido(strAutInc, strSeqGer: String): Boolean;
  Var
    objExpede : TEspelhoCapa;
begin
  Result := False;
  Try
    Try
      objExpede := TEspelhoCapa.Create;
      If objExpede.fCarregaRegistro(strAutInc) Then
      Begin
        objExpede.strMovGer := strSeqGer;
        Result := objExpede.fSalva;
      End;
    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message,'');
      End;
    end;

  Finally
    FreeAndNil(objExpede);
  End;
end;

class function TEspelhoCapa.fMarcaComoExpedido(strAutInc: String): Boolean;
  Var
    objExpede : TEspelhoCapa;
begin
  Result := True;
  Try
    Try
      objExpede := TEspelhoCapa.Create;
      If objExpede.fCarregaRegistro(strAutInc) Then
      Begin
        objExpede.strOpeExp := strLoginUsuarioLogado;
        objExpede.dtaDtaExp := fNow;
        objExpede.dtaHraExp := fNow;
        Result := objExpede.fSalva;
      End;
    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message,'');
      End;
    end;

  Finally
    FreeAndNil(objExpede);
  End;

end;

class function TEspelhoCapa.fReabrirEspelho(strAutInc: String): Boolean;
  Var
    objExpede : TEspelhoCapa;
begin
  Result := True;
  Try
    Try
      objExpede := TEspelhoCapa.Create;
      If objExpede.fCarregaRegistro(strAutInc) Then
      Begin
        objExpede.strOpeExp := '';
        objExpede.dtaDtaExp := 0;
        objExpede.dtaHraExp := 0;
        objExpede.strMovGer := '';
        Result := objExpede.fSalva;
      End;
    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message,'');
      End;
    end;

  Finally
    FreeAndNil(objExpede);
  End;


end;

function TEspelhoCapa.fSalva: Boolean;
  Var
    qryEspGer : TUniQuery;
begin
  Try
    Try
      qryEspGer := fCriaQuery;
      With qryEspGer, SQL Do
      Begin
        { Insere Registro }
        If fEmptyStr(FAutInc) Then
        Begin
          Close;
          Clear;
          Add(' INSERT INTO ESPGER(AUTOINCREM, ');
          Add('                    GER_CODEMP, ');
          Add('                    GER_NUMESP, ');
          Add('                    GER_CODFOR, ');
          Add('                    GER_CODCLI, ');
          Add('                    GER_TIP_FC, ');
          Add('                    GER_CODADE, ');
          Add('                    GER_CLAFIS, ');
          Add('                    GER_TOTPRO, ');
          Add('                    GER_TOTIPI, ');
          Add('                    GER_TOTRET, ');
          Add('                    GER_TOTCBS, ');
          Add('                    GER_TOTIBS, ');
          Add('                    GER_TOT_IS, ');
          Add('                    GER_TOTFCP, ');
          Add('                    GER_TOTFRE, ');
          Add('                    GER_DESACE, ');
          Add('                    GER_VLRCON, ');
          Add('                    GER_QTDITE, ');
          Add('                    GER_MOVGER, ');
          Add('                    GER_CONPAG, ');
          Add('                    GER_CODCND, ');
          Add('                    GER_CODFPG, ');
          Add('                    GER_VPAR01, ');
          Add('                    GER_VPAR02, ');
          Add('                    GER_VPAR03, ');
          Add('                    GER_VPAR04, ');
          Add('                    GER_VPAR05, ');
          Add('                    GER_VPAR06, ');
          Add('                    GER_VPAR07, ');
          Add('                    GER_VPAR08, ');
          Add('                    GER_VPAR09, ');
          Add('                    GER_VPAR10, ');
          Add('                    GER_VPAR11, ');
          Add('                    GER_VPAR12, ');
          Add('                    GER_CNFNFE, ');
          Add('                    GER_CODTRA, ');
          Add('                    GER_BASIPI, ');
          Add('                    GER_ALQIPI, ');
          Add('                    GER_BASICM, ');
          Add('                    GER_ALQICM, ');
          Add('                    GER_TOTICM, ');
          Add('                    GER_ALQRET, ');
          Add('                    GER_BASRET, ');
          Add('                    GER_ALQFCP, ');
          Add('                    GER_BASFCP, ');
          Add('                    GER_DESESP, ');
          Add('                    GER_TIPFRE, ');
          Add('                    GER_PESBRU, ');
          Add('                    GER_PESLIQ, ');
          Add('                    GER_VOLUME, ');
          Add('                    GER_ESPECI, ');
          Add('                    GER_MARCA_, ');
          Add('                    GER_NUMERA, ');
          Add('                    GER_OPEEXP, ');
          Add('                    GER_DTAEXP, ');
          Add('                    GER_HRAEXP, ');
          Add('                    GER_MEN001, ');
          Add('                    GER_MEN002, ');
          Add('                    GER_MEN003, ');
          Add('                    GER_MEN004, ');
          Add('                    GER_MEN005, ');
          Add('                    GER_CHVNFE, ');
          Add('                    GER_NATOPE, ');
          Add('                    GER_NUMREM, ');
          Add('                    GER_PLAFAT)');
          Add('             VALUES(:AUTINC,    ');
          Add('                    :CODEMP,    ');
          Add('                    :NUMESP,    ');
          Add('                    :CODFOR,    ');
          Add('                    :CODCLI,    ');
          Add('                    :TIP_FC,    ');
          Add('                    :CODADE,    ');
          Add('                    :CLAFIS,    ');
          Add('                    :TOTPRO,    ');
          Add('                    :TOTIPI,    ');
          Add('                    :TOTRET,    ');
          Add('                    :TOTCBS,    ');
          Add('                    :TOTIBS,    ');
          Add('                    :TOT_IS,    ');
          Add('                    :TOTFCP,    ');
          Add('                    :TOTFRE,    ');
          Add('                    :DESACE,    ');
          Add('                    :VLRCON,    ');
          Add('                    :QTDITE,    ');
          Add('                    :MOVGER,    ');
          Add('                    :CONPAG,    ');
          Add('                    :CODCND,    ');
          Add('                    :CODFPG,    ');
          Add('                    :VPAR01,    ');
          Add('                    :VPAR02,    ');
          Add('                    :VPAR03,    ');
          Add('                    :VPAR04,    ');
          Add('                    :VPAR05,    ');
          Add('                    :VPAR06,    ');
          Add('                    :VPAR07,    ');
          Add('                    :VPAR08,    ');
          Add('                    :VPAR09,    ');
          Add('                    :VPAR10,    ');
          Add('                    :VPAR11,    ');
          Add('                    :VPAR12,    ');
          Add('                    :CNFNFE,    ');
          Add('                    :CODTRA,    ');
          Add('                    :BASIPI,    ');
          Add('                    :ALQIPI,    ');
          Add('                    :BASICM,    ');
          Add('                    :ALQICM,    ');
          Add('                    :TOTICM,    ');
          Add('                    :ALQRET,    ');
          Add('                    :BASRET,    ');
          Add('                    :ALQFCP,    ');
          Add('                    :BASFCP,    ');
          Add('                    :DESESP,    ');
          Add('                    :TIPFRE,    ');
          Add('                    :PESBRU,    ');
          Add('                    :PESLIQ,    ');
          Add('                    :VOLUME,    ');
          Add('                    :ESPECI,    ');
          Add('                    :MARCA_,    ');
          Add('                    :NUMERA,    ');
          Add('                    :OPEEXP,    ');
          Add('                    :DTAEXP,    ');
          Add('                    :HRAEXP,    ');
          Add('                    :MEN001,    ');
          Add('                    :MEN002,    ');
          Add('                    :MEN003,    ');
          Add('                    :MEN004,    ');
          Add('                    :MEN005,    ');
          Add('                    :CHVNFE,    ');
          Add('                    :NATOPE,    ');
          Add('                    :NUMREM,    ');
          Add('                    :PLAFAT)    ');

          FAutInc := fRetAutoIncrem('ESPGER', VS_strCodEmp);

        End
        Else
        { Edita Registro }
        Begin
          Close;
          Clear;
          Add('UPDATE ESPGER SET GER_CODEMP = :CODEMP, ');
          Add('                  GER_NUMESP = :NUMESP, ');
          Add('                  GER_CODFOR = :CODFOR, ');
          Add('                  GER_CODCLI = :CODCLI, ');
          Add('                  GER_TIP_FC = :TIP_FC, ');
          Add('                  GER_CODADE = :CODADE, ');
          Add('                  GER_CLAFIS = :CLAFIS, ');
          Add('                  GER_TOTPRO = :TOTPRO, ');
          Add('                  GER_TOTIPI = :TOTIPI, ');
          Add('                  GER_TOTRET = :TOTRET, ');
          Add('                  GER_TOTCBS = :TOTCBS, ');
          Add('                  GER_TOTIBS = :TOTIBS, ');
          Add('                  GER_TOT_IS = :TOT_IS, ');
          Add('                  GER_TOTFCP = :TOTFCP, ');
          Add('                  GER_TOTFRE = :TOTFRE, ');
          Add('                  GER_DESACE = :DESACE, ');
          Add('                  GER_VLRCON = :VLRCON, ');
          Add('                  GER_QTDITE = :QTDITE, ');
          Add('                  GER_MOVGER = :MOVGER, ');
          Add('                  GER_CONPAG = :CONPAG, ');
          Add('                  GER_CODCND = :CODCND, ');
          Add('                  GER_CODFPG = :CODFPG, ');
          Add('                  GER_VPAR01 = :VPAR01, ');
          Add('                  GER_VPAR02 = :VPAR02, ');
          Add('                  GER_VPAR03 = :VPAR03, ');
          Add('                  GER_VPAR04 = :VPAR04, ');
          Add('                  GER_VPAR05 = :VPAR05, ');
          Add('                  GER_VPAR06 = :VPAR06, ');
          Add('                  GER_VPAR07 = :VPAR07, ');
          Add('                  GER_VPAR08 = :VPAR08, ');
          Add('                  GER_VPAR09 = :VPAR09, ');
          Add('                  GER_VPAR10 = :VPAR10, ');
          Add('                  GER_VPAR11 = :VPAR11, ');
          Add('                  GER_VPAR12 = :VPAR12, ');
          Add('                  GER_CNFNFE = :CNFNFE, ');
          Add('                  GER_CODTRA = :CODTRA, ');
          Add('                  GER_BASIPI = :BASIPI, ');
          Add('                  GER_ALQIPI = :ALQIPI, ');
          Add('                  GER_BASICM = :BASICM, ');
          Add('                  GER_ALQICM = :ALQICM, ');
          Add('                  GER_TOTICM = :TOTICM, ');
          Add('                  GER_ALQRET = :ALQRET, ');
          Add('                  GER_BASRET = :BASRET, ');
          Add('                  GER_ALQFCP = :ALQFCP, ');
          Add('                  GER_BASFCP = :BASFCP, ');
          Add('                  GER_DESESP = :DESESP, ');
          Add('                  GER_TIPFRE = :TIPFRE, ');
          Add('                  GER_PESBRU = :PESBRU, ');
          Add('                  GER_PESLIQ = :PESLIQ, ');
          Add('                  GER_VOLUME = :VOLUME, ');
          Add('                  GER_ESPECI = :ESPECI, ');
          Add('                  GER_MARCA_ = :MARCA_, ');
          Add('                  GER_NUMERA = :NUMERA, ');
          Add('                  GER_OPEEXP = :OPEEXP, ');
          Add('                  GER_DTAEXP = :DTAEXP, ');
          Add('                  GER_HRAEXP = :HRAEXP, ');
          Add('                  GER_MEN001 = :MEN001, ');
          Add('                  GER_MEN002 = :MEN002, ');
          Add('                  GER_MEN003 = :MEN003, ');
          Add('                  GER_MEN004 = :MEN004, ');
          Add('                  GER_MEN005 = :MEN005, ');
          Add('                  GER_CHVNFE = :CHVNFE, ');
          Add('                  GER_NATOPE = :NATOPE, ');
          Add('                  GER_NUMREM = :NUMREM, ');
          Add('                  GER_PLAFAT = :PLAFAT  ');
          Add(' WHERE AUTOINCREM = :AUTINC             ');
        End;

        ParamByName('AUTINC').AsString  := FAutInc;
        ParamByName('CODEMP').AsString  := FCodEmp;
        ParamByName('NUMESP').AsString  := FNumEsp;

        If Not fEmptyStr(FCodFor) Then
          ParamByName('CODFOR').AsString  := FCodFor;

        If Not fEmptyStr(FCodCli) Then
          ParamByName('CODCLI').AsString  := FCodCli;

        ParamByName('TIP_FC').AsString  := FTip_FC;
        ParamByName('CODADE').AsString  := FCodAde;
        ParamByName('CLAFIS').AsString  := FClaFis;
        ParamByName('TOTPRO').AsFloat   := FTotPro;
        ParamByName('TOTIPI').AsFloat   := FTotIpi;
        ParamByName('TOTRET').AsFloat   := FTotRet;
        ParamByName('TOTCBS').AsFloat   := FTotCbs;
        ParamByName('TOTIBS').AsFloat   := FTotIbs;
        ParamByName('TOT_IS').AsFloat   := FTot_Is;
        ParamByName('TOTFCP').AsFloat   := FTotFcpST;
        ParamByName('TOTFRE').AsFloat   := FTotFre;
        ParamByName('DESACE').AsFloat   := FDesAce;
        ParamByName('VLRCON').AsFloat   := FVlrCon;
        ParamByName('QTDITE').AsInteger := FQtdIte;
        ParamByName('CONPAG').AsString  := FConPag;
        ParamByName('CODCND').AsString  := FCodCnd;
        ParamByName('CODFPG').AsString  := FCodFpg;
        ParamByName('VPAR01').AsFloat   := FVPar01;
        ParamByName('VPAR02').AsFloat   := FVPar02;
        ParamByName('VPAR03').AsFloat   := FVPar03;
        ParamByName('VPAR04').AsFloat   := FVPar04;
        ParamByName('VPAR05').AsFloat   := FVPar05;
        ParamByName('VPAR06').AsFloat   := FVPar06;
        ParamByName('VPAR07').AsFloat   := FVPar07;
        ParamByName('VPAR08').AsFloat   := FVPar08;
        ParamByName('VPAR09').AsFloat   := FVPar09;
        ParamByName('VPAR10').AsFloat   := FVPar10;
        ParamByName('VPAR11').AsFloat   := FVPar11;
        ParamByName('VPAR12').AsFloat   := FVPar12;
        ParamByName('CNFNFE').AsString  := FCnfNfe;
        ParamByName('CODTRA').AsString  := FCodTra;
        ParamByName('BASIPI').AsFloat   := FBasIPI;
        ParamByName('ALQIPI').AsFloat   := FAlqIPI;
        ParamByName('BASICM').AsFloat   := FBasIcm;
        ParamByName('ALQICM').AsFloat   := FAlqICM;
        ParamByName('TOTICM').AsFloat   := FTotICM;
        ParamByName('ALQRET').AsFloat   := FAlqRet;
        ParamByName('BASRET').AsFloat   := FBasRet;
        ParamByName('ALQFCP').AsFloat   := FAlqFcpST;
        ParamByName('BASFCP').AsFloat   := FBasFcpST;
        ParamByName('DESESP').AsFloat   := FDesEsp;
        ParamByName('TIPFRE').AsString  := FTipFre;
        ParamByName('PESBRU').AsFloat   := FPesBru;
        ParamByName('PESLIQ').AsFloat   := FPesLiq;
        ParamByName('VOLUME').AsFloat   := FVolume;
        ParamByName('ESPECI').AsString  := FEspeci;
        ParamByName('MARCA_').AsString  := FMarca_;
        ParamByName('NUMERA').AsString  := FNumera;
        ParamByName('OPEEXP').AsString  := FOpeExp;
        ParamByName('DTAEXP').AsDateTime := FDtaExp;
        ParamByName('HRAEXP').AsDateTime := FHraExp;
        ParamByName('MEN001').AsString  := FMen001;
        ParamByName('MEN002').AsString  := FMen002;
        ParamByName('MEN003').AsString  := FMen003;
        ParamByName('MEN004').AsString  := FMen004;
        ParamByName('MEN005').AsString  := FMen005;
        ParamByName('CHVNFE').AsString  := FChvNFE;
        ParamByName('NATOPE').AsString  := FNatOpe;

        If fEmptyStr(ParamByName('OPEEXP').AsString) Then
          ParamByName('OPEEXP').Clear;

        If ParamByName('DTAEXP').AsDateTime = 0 Then
          ParamByName('DTAEXP').Clear;

        If ParamByName('HRAEXP').AsDateTime = 0 Then
          ParamByName('HRAEXP').Clear;

        If not fEmptyStr(FMovGer) Then
          ParamByName('MOVGER').AsString := FMovGer
        Else
          ParamByName('MOVGER').Clear;

        If not fEmptyStr(FNumREm) Then
          ParamByName('NUMREM').AsString := FNumRem
        Else
          ParamByName('NUMREM').Clear;

        If (Not fEmptyStr(FPlaFat)) Then
          ParamByName('PLAFAT').AsString := FPlaFat
        Else
          ParamByName('PLAFAT').Clear;

        ExecSQL;
        Result := True;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '');
      End;
    End;

  Finally
    FreeAndNil(qryEspGer);
  End;

end;

{ TEspelhoDetalhe }

constructor TEspelhoDetalhe.Create;
begin
  FAutInc := '';
  FSeqGer := '';
  FCodIte := '';
  FDesIte := '';
  FDesNes := '';
  FQtdIte := 0;
  FUnitar := 0;
  FCodFis := '';
  FCodAbf := '';
  FTotIte := 0;
  FBasIcm := 0;
  FAlqIcm := 0;
  FValIcm := 0;
  FBasIpi := 0;
  FAlqIpi := 0;
  FValIpi := 0;
  FBasRet := 0;
  FValRet := 0;
  FValCbs := 0;
  FValIbs := 0;
  FVal_Is := 0;
  FBasPis := 0;
  FAlqPis := 0;
  FValPis := 0;
  FCstPis := '';
  FBasCoF := 0;
  FAlqCof := 0;
  FValCof := 0;
  FCstCof := '';
  FClaFis := '';
  FBasVrd := 0;
  FVrdIcm := 0;
  FMtdIcm := '';
  FSeqDet := '';
  FDescon := 0;
  FDesEsp := 0;
  FUniOri := 0;
  FUniDig := 0;
  FIncPis := '';
  FQtdExp := 0;
  FDocDev := '';
  FEspDev := '';
  FEmpDev := '';
  FstrNumeroDoLote := '';
  FDesAce   := 0;
  FVlrCon   := 0;
  FTotFre   := 0;
  FVal_Rt   := 0;
  FPebaST   := 0;
  FValIva   := 0;
  FPerRed   := 0;
  FAlqRet   := 0;
  FNr_Pis   := EmptyStr;
  FNr_Cof   := EmptyStr;
end;

function TEspelhoDetalhe.fCarregaRegistro(strAutInc: String): Boolean;
  Var
    qryEspDet : TUniQuery;
Begin
  Try
    Try
      qryEspDet := fCriaQuery;
      With qryEspDet, SQL Do
      Begin
        Close;
        Clear;
        Add('SELECT * FROM ESPDET WHERE AUTOINCREM = :AUTINC ');
        ParamByName('AUTINC').AsString := strAutInc;
        Open;

        Result := not isEmpty;

        If Result Then
        Begin
          Self.strAutInc       := FieldByName('AUTOINCREM').AsString;
          Self.strSeqGer       := FieldByName('DET_SEQGER').AsString;
          Self.strCodIte       := FieldByName('DET_CODITE').AsString;
          Self.strDesIte       := FieldByName('DET_DESCRI').AsString;
          Self.strDesNes       := FieldByName('DET_DESNES').AsString;
          Self.fltQtdIte       := FieldByName('DET_QTDITE').AsFloat;
          Self.fltUnitar       := FieldByName('DET_UNITAR').AsFloat;
          Self.strCodFis       := FieldByName('DET_CODFIS').AsString;
          Self.strCodAbf       := FieldByName('DET_CODABF').AsString;
          Self.fltTotIte       := FieldByName('DET_TOTITE').AsFloat;
          Self.fltBasIcm       := FieldByName('DET_BASICM').AsFloat;
          Self.fltAlqIcm       := FieldByName('DET_ALQICM').AsFloat;
          Self.fltValIcm       := FieldByName('DET_VALICM').AsFloat;
          Self.fltBasIpi       := FieldByName('DET_BASIPI').AsFloat;
          Self.fltAlqIpi       := FieldByName('DET_ALQIPI').AsFloat;
          Self.fltValIpi       := FieldByName('DET_VALIPI').AsFloat;
          Self.fltBasRet       := FieldByName('DET_BASRET').AsFloat;
          Self.fltValRet       := FieldByName('DET_VALRET').AsFloat;
          Self.fltValCBS       := FieldByName('DET_VALCBS').AsFloat;
          Self.fltValIBS       := FieldByName('DET_VALIBS').AsFloat;
          Self.fltVal_IS       := FieldByName('DET_VAL_IS').AsFloat;
          Self.fltBasPis       := FieldByName('DET_BASPIS').AsFloat;
          Self.fltAlqPis       := FieldByName('DET_ALQPIS').AsFloat;
          Self.fltValPis       := FieldByName('DET_VALPIS').AsFloat;
          Self.strCstPis       := FieldByName('DET_CSTPIS').AsString;
          Self.fltBasCoF       := FieldByName('DET_BASCOF').AsFloat;
          Self.fltAlqCof       := FieldByName('DET_ALQCOF').AsFloat;
          Self.fltValCof       := FieldByName('DET_VALCOF').AsFloat;
          Self.strCstCof       := FieldByName('DET_CSTCOF').AsString;
          Self.strClaFis       := FieldByName('DET_CLAFIS').AsString;
          Self.fltBasVrd       := FieldByName('DET_BASVRD').AsFloat;
          Self.fltVrdIcm       := FieldByName('DET_VRDICM').AsFloat;
          Self.strMtdIcm       := FieldByName('DET_MTDICM').AsString;
          Self.strSeqDet       := FieldByName('DET_SEQDET').AsString;
          Self.fltDescon       := FieldByName('DET_DESCON').AsFloat;
          Self.fltDesEsp       := FieldByName('DET_DESESP').AsFloat;
          Self.fltUniOri       := FieldByName('DET_UNIORI').AsFloat;
          Self.fltUniDig       := FieldByName('DET_UNIDIG').AsFloat;
          Self.strIncPis       := FieldByName('DET_INCPIS').AsString;
          Self.fltQtdExp       := FieldByName('DET_QTDEXP').AsFloat;
          Self.fltBasFcp       := FieldByName('DET_BASFCP').AsFloat;
          Self.fltPerFcp       := FieldByName('DET_PERFCP').AsFloat;
          Self.fltValFcp       := FieldByName('DET_VALFCP').AsFloat;
          Self.fltBFcpST       := FieldByName('DET_BFCPST').AsFloat;
          Self.fltPFcpST       := FieldByName('DET_PFCPST').AsFloat;
          Self.fltVFcpST       := FieldByName('DET_VFCPST').AsFloat;
          Self.strDocDev       := FieldByName('DET_DOCDEV').AsString;
          Self.strEspDev       := FieldByName('DET_ESPDEV').AsString;
          Self.strEmpDev       := FieldByName('DET_EMPDEV').AsString;
          Self.strNumeroDoLote := FieldByName('DET_NUMLOT').AsString;
          Self.fltDesAce       := FieldByName('DET_DESACE').AsFloat;
          Self.fltVlrCon       := FieldByName('DET_VLRCON').AsFloat;
          Self.fltTotFre       := FieldByName('DET_TOTFRE').AsFloat;
          Self.fltVal_Rt       := FieldByName('DET_VAL_RT').AsFloat;
          Self.fltValIva       := FieldByName('DET_VALIVA').AsFloat;
          Self.fltPerRed       := FieldByName('DET_PERRED').AsFloat;
          Self.fltAlqRet       := FieldByName('DET_ALQRET').AsFloat;
          Self.fltPebaST       := FieldByName('DET_PEBAST').AsFloat;
          Self.strNr_Pis       := FieldByName('DET_NR_PIS').AsString;
          Self.strNr_Cof       := FieldByName('DET_NR_COF').AsString;
        End;

      End;

    Finally
      FreeAndNil(qryEspDet);
    End;

  Except
    On E : Exception Do
    Begin
      pMensagensErro(E.Message, '');
      Result := False;
    End;
  End;

end;

function TEspelhoDetalhe.fSalva: Boolean;
  Var
    qryEspDet : TUniQuery;
begin
  Result := False;
  Try
    Try
      qryEspDet := fCriaQuery;
      With qryEspDet, SQL Do
      Begin
        { Insere Registro }
        If fEmptyStr(FAutInc) Then
        Begin
          Close;
          Clear;
          Add(' INSERT INTO ESPDET(AUTOINCREM, ');
          Add('                    DET_SEQGER, ');
          Add('                    DET_CODITE, ');
          Add('                    DET_DESCRI, ');
          Add('                    DET_DESNES, ');
          Add('                    DET_QTDITE, ');
          Add('                    DET_UNITAR, ');
          Add('                    DET_CODFIS, ');
          Add('                    DET_CODABF, ');
          Add('                    DET_TOTITE, ');
          Add('                    DET_BASICM, ');
          Add('                    DET_ALQICM, ');
          Add('                    DET_VALICM, ');
          Add('                    DET_BASIPI, ');
          Add('                    DET_ALQIPI, ');
          Add('                    DET_VALIPI, ');
          Add('                    DET_BASRET, ');
          Add('                    DET_VALRET, ');
          Add('                    DET_VALCBS, ');
          Add('                    DET_VALIBS, ');
          Add('                    DET_VAL_IS, ');
          Add('                    DET_BASPIS, ');
          Add('                    DET_ALQPIS, ');
          Add('                    DET_VALPIS, ');
          Add('                    DET_CSTPIS, ');
          Add('                    DET_BASCOF, ');
          Add('                    DET_ALQCOF, ');
          Add('                    DET_VALCOF, ');
          Add('                    DET_CSTCOF, ');
          Add('                    DET_CLAFIS, ');
          Add('                    DET_BASVRD, ');
          Add('                    DET_VRDICM, ');
          Add('                    DET_MTDICM, ');
          Add('                    DET_SEQDET, ');
          Add('                    DET_DESCON, ');
          Add('                    DET_DESESP, ');
          Add('                    DET_UNIORI, ');
          Add('                    DET_UNIDIG, ');
          Add('                    DET_INCPIS, ');
          Add('                    DET_QTDEXP, ');
          Add('                    DET_BASFCP, ');
          Add('                    DET_PERFCP, ');
          Add('                    DET_VALFCP, ');
          Add('                    DET_BFCPST, ');
          Add('                    DET_PFCPST, ');
          Add('                    DET_VFCPST, ');
          Add('                    DET_DOCDEV, ');
          Add('                    DET_ESPDEV, ');
          Add('                    DET_EMPDEV, ');
          Add('                    DET_NUMLOT, ');
          Add('                    DET_DESACE, ');
          Add('                    DET_VLRCON, ');
          Add('                    DET_TOTFRE, ');
          Add('                    DET_VAL_RT, ');
          Add('                    DET_VALIVA, ');
          Add('                    DET_PERRED, ');
          Add('                    DET_ALQRET, ');
          Add('                    DET_PEBAST, ');
          Add('                    DET_NR_PIS, ');
          Add('                    DET_NR_COF) ');

          Add('             VALUES(:AUTINC,    ');
          Add('                    :SEQGER,    ');
          Add('                    :CODITE,    ');
          Add('                    :DESCRI,    ');
          Add('                    :DESNES,    ');
          Add('                    :QTDITE,    ');
          Add('                    :UNITAR,    ');
          Add('                    :CODFIS,    ');
          Add('                    :CODABF,    ');
          Add('                    :TOTITE,    ');
          Add('                    :BASICM,    ');
          Add('                    :ALQICM,    ');
          Add('                    :VALICM,    ');
          Add('                    :BASIPI,    ');
          Add('                    :ALQIPI,    ');
          Add('                    :VALIPI,    ');
          Add('                    :BASRET,    ');
          Add('                    :VALRET,    ');
          Add('                    :VALCBS,    ');
          Add('                    :VALIBS,    ');
          Add('                    :VAL_IS,    ');
          Add('                    :BASPIS,    ');
          Add('                    :ALQPIS,    ');
          Add('                    :VALPIS,    ');
          Add('                    :CSTPIS,    ');
          Add('                    :BASCOF,    ');
          Add('                    :ALQCOF,    ');
          Add('                    :VALCOF,    ');
          Add('                    :CSTCOF,    ');
          Add('                    :CLAFIS,    ');
          Add('                    :BASVRD,    ');
          Add('                    :VRDICM,    ');
          Add('                    :MTDICM,    ');
          Add('                    :SEQDET,    ');
          Add('                    :DESCON,    ');
          Add('                    :DESESP,    ');
          Add('                    :UNIORI,    ');
          Add('                    :UNIDIG,    ');
          Add('                    :INCPIS,    ');
          Add('                    :QTDEXP,    ');
          Add('                    :BASFCP,    ');
          Add('                    :PERFCP,    ');
          Add('                    :VALFCP,    ');
          Add('                    :BFCPST,    ');
          Add('                    :PFCPST,    ');
          Add('                    :VFCPST,    ');
          Add('                    :DOCDEV,    ');
          Add('                    :ESPDEV,    ');
          Add('                    :EMPDEV,    ');
          Add('                    :NUMLOT,    ');
          Add('                    :DESACE,    ');
          Add('                    :VLRCON,    ');
          Add('                    :TOTFRE,    ');
          Add('                    :VAL_RT,    ');
          Add('                    :VALIVA,    ');
          Add('                    :PERRED,    ');
          Add('                    :ALQRET,    ');
          Add('                    :PEBAST,    ');
          Add('                    :NR_PIS,    ');
          Add('                    :NR_COF)    ');

          FAutInc := fRetAutoIncrem('ESPDET', VS_strCodEmp);

        End
        Else
        { Edita Registro }
        Begin
          Close;
          Clear;
          Add('UPDATE ESPDET SET DET_SEQGER = :SEQGER, ');
          Add('                  DET_CODITE = :CODITE, ');
          Add('                  DET_DESCRI = :DESCRI, ');
          Add('                  DET_DESNES = :DESNES, ');
          Add('                  DET_QTDITE = :QTDITE, ');
          Add('                  DET_UNITAR = :UNITAR, ');
          Add('                  DET_CODFIS = :CODFIS, ');
          Add('                  DET_CODABF = :CODABF, ');
          Add('                  DET_TOTITE = :TOTITE, ');
          Add('                  DET_BASICM = :BASICM, ');
          Add('                  DET_ALQICM = :ALQICM, ');
          Add('                  DET_VALICM = :VALICM, ');
          Add('                  DET_BASIPI = :BASIPI, ');
          Add('                  DET_ALQIPI = :ALQIPI, ');
          Add('                  DET_VALIPI = :VALIPI, ');
          Add('                  DET_BASRET = :BASRET, ');
          Add('                  DET_VALRET = :VALRET, ');
          Add('                  DET_VALCBS = :VALCBS, ');
          Add('                  DET_VALIBS = :VALIBS, ');
          Add('                  DET_VAL_IS = :VAL_IS, ');
          Add('                  DET_BASPIS = :BASPIS, ');
          Add('                  DET_ALQPIS = :ALQPIS, ');
          Add('                  DET_VALPIS = :VALPIS, ');
          Add('                  DET_CSTPIS = :CSTPIS, ');
          Add('                  DET_BASCOF = :BASCOF, ');
          Add('                  DET_ALQCOF = :ALQCOF, ');
          Add('                  DET_VALCOF = :VALCOF, ');
          Add('                  DET_CSTCOF = :CSTCOF, ');
          Add('                  DET_CLAFIS = :CLAFIS, ');
          Add('                  DET_BASVRD = :BASVRD, ');
          Add('                  DET_VRDICM = :VRDICM, ');
          Add('                  DET_MTDICM = :MTDICM, ');
          Add('                  DET_SEQDET = :SEQDET, ');
          Add('                  DET_DESCON = :DESCON, ');
          Add('                  DET_DESESP = :DESESP, ');
          Add('                  DET_UNIORI = :UNIORI, ');
          Add('                  DET_UNIDIG = :UNIDIG, ');
          Add('                  DET_INCPIS = :INCPIS, ');
          Add('                  DET_QTDEXP = :QTDEXP, ');
          Add('                  DET_BASFCP = :BASFCP, ');
          Add('                  DET_PERFCP = :PERFCP, ');
          Add('                  DET_VALFCP = :VALFCP, ');
          Add('                  DET_BFCPST = :BFCPST, ');
          Add('                  DET_PFCPST = :PFCPST, ');
          Add('                  DET_VFCPST = :VFCPST, ');
          Add('                  DET_DOCDEV = :DOCDEV, ');
          Add('                  DET_ESPDEV = :ESPDEV, ');
          Add('                  DET_EMPDEV = :EMPDEV, ');
          Add('                  DET_NUMLOT = :NUMLOT, ');
          Add('                  DET_DESACE = :DESACE, ');
          Add('                  DET_VLRCON = :VLRCON, ');
          Add('                  DET_TOTFRE = :TOTFRE, ');
          Add('                  DET_VAL_RT = :VAL_RT, ');
          Add('                  DET_VALIVA = :VALIVA, ');
          Add('                  DET_PERRED = :PERRED, ');
          Add('                  DET_ALQRET = :ALQRET, ');
          Add('                  DET_PEBAST = :PEBAST, ');
          Add('                  DET_NR_PIS = :NR_PIS, ');
          Add('                  DET_NR_COF = :NR_COF  ');
          Add(' WHERE AUTOINCREM = :AUTINC             ');
        End;

        ParamByName('AUTINC').AsString := FAutInc;
        ParamByName('SEQGER').AsString := FSeqGer;
        ParamByName('CODITE').AsString := FCodIte;
        ParamByName('DESCRI').AsString := FDesIte;
        ParamByName('DESNES').AsString := FDesNes;
        ParamByName('QTDITE').AsFloat  := FQtdIte;
        ParamByName('UNITAR').AsFloat  := FUnitar;
        ParamByName('CODFIS').AsString := FCodFis;
        ParamByName('CODABF').AsString := FCodAbf;
        ParamByName('TOTITE').AsFloat  := FTotIte;
        ParamByName('BASICM').AsFloat  := FBasIcm;
        ParamByName('ALQICM').AsFloat  := FAlqIcm;
        ParamByName('VALICM').AsFloat  := FValIcm;
        ParamByName('BASIPI').AsFloat  := FBasIpi;
        ParamByName('ALQIPI').AsFloat  := FAlqIpi;
        ParamByName('VALIPI').AsFloat  := FValIpi;
        ParamByName('BASRET').AsFloat  := FBasRet;
        ParamByName('VALRET').AsFloat  := FValRet;
        ParamByName('VALCBS').AsFloat  := FValCbs;
        ParamByName('VALIBS').AsFloat  := FValIbs;
        ParamByName('VAL_IS').AsFloat  := FVal_Is;
        ParamByName('BASPIS').AsFloat  := FBasPis;
        ParamByName('ALQPIS').AsFloat  := FAlqPis;
        ParamByName('VALPIS').AsFloat  := FValPis;
        ParamByName('CSTPIS').AsString := FCstPis;
        ParamByName('BASCOF').AsFloat  := FBasCoF;
        ParamByName('ALQCOF').AsFloat  := FAlqCof;
        ParamByName('VALCOF').AsFloat  := FValCof;
        ParamByName('CSTCOF').AsString := FCstCof;

        if Length(FClaFis) <> 4 then
          raise Exception.Create(' Classificação fiscal inválida. Contate a Citel.')
        else
          ParamByName('CLAFIS').AsString := FClaFis;

        ParamByName('BASVRD').AsFloat  := FBasVrd;
        ParamByName('VRDICM').AsFloat  := FVrdIcm;
        ParamByName('MTDICM').AsString := FMtdIcm;
        ParamByName('DESCON').AsFloat  := FDescon;
        ParamByName('DESESP').AsFloat  := FDesEsp;
        ParamByName('UNIORI').AsFloat  := FUniOri;
        ParamByName('UNIDIG').AsFloat  := FUniDig;
        ParamByName('INCPIS').AsString := FIncPis;
        ParamByName('QTDEXP').AsFloat  := FQtdExp;

        ParamByName('BASFCP').AsFloat  := FBasFcp;
        ParamByName('PERFCP').AsFloat  := FPerFcp;
        ParamByName('VALFCP').AsFloat  := FValFcp;

        ParamByName('BFCPST').AsFloat  := FBFcpST;
        ParamByName('PFCPST').AsFloat  := FPFcpST;
        ParamByName('VFCPST').AsFloat  := FVFcpST;

        ParamByName('DOCDEV').AsString := FDocDev;
        ParamByName('ESPDEV').AsString := FEspDev;
        ParamByName('EMPDEV').AsString := FEmpDev;

        ParamByName('DESACE').AsFloat  := FDesAce;
        ParamByName('VLRCON').AsFloat  := FVlrCon;
        ParamByName('TOTFRE').AsFloat  := FTotFre;
        ParamByName('VAL_RT').AsFloat  := FVal_RT;
        ParamByName('VALIVA').AsFloat  := FValIva;
        ParamByName('PERRED').AsFloat  := FPerRed;
        ParamByName('ALQRET').AsFloat  := FAlqRet;
        ParamByName('PEBAST').AsFloat  := FPebAST;
        ParamByName('NR_PIS').AsString := FNr_Pis;
        ParamByName('NR_COF').AsString := FNr_Cof;

        If Not fEmptyStr(FSeqDet) Then
          ParamByName('SEQDET').AsString := FSeqDet
        Else
          ParamByName('SEQDET').Clear;

        If Not fEmptyStr(FstrNumeroDoLote) Then
          ParamByName('NUMLOT').AsString := FstrNumeroDoLote
        Else
          ParamByName('NUMLOT').Clear;

        ExecSQL;
        Result := True;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '');
      End;
    End;

  Finally
    FreeAndNil(qryEspDet);
  End;


end;

class function TEspelhoDetalhe.fZerarContagem(strSeqGer: String): Boolean;
  Var
    qryUpdate : TUniQuery;
begin
  Try
    qryUpdate := fCriaQuery;
    With qryUpdate, SQL Do
    Begin
      Close;
      Clear;
      Add('UPDATE ESPDET SET DET_QTDEXP = 0 ');
      Add('WHERE DET_SEQGER = :SEQGER       ');

      Try
        ParamByName('SEQGER').AsString := strSeqGer;
        ExecSQL;
        Result := True;
      Except
        On E : Exception Do
        Begin
          pMensagensErro(E.Message, '');
          Result := False;
        End;

      End;

    End;

  Finally
    FreeAndNil(qryUpdate);
  End;
end;

function fRetornaQuantidadeDevolucaoEmAbertoNoEspelho(strAutDet : String): Double;
  Var
    qryQuery : TUniQuery;
Begin
  Try
    qryQuery := fCriaQuery;
    With qryQuery, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT SUM(DET_QTDITE) AS QTDITE                    ');
      Add(' FROM ESPDET                                         ');
      Add(' INNER JOIN ESPGER ON ESPGER.AUTOINCREM = DET_SEQGER ');
      Add(' WHERE DET_SEQDET = :SEQDET                          ');
      Add('   AND GER_MOVGER IS NULL                            ');

      ParamByName('SEQDET').AsString := strAutDet;

      Open;

      Result := FieldByName('QTDITE').AsFloat;

      Close;

    End;

  Finally
    FreeAndNil(qryQuery);
  End;
End;

{ TEspelhoChaveReferenciada }

procedure TEspelhoChaveReferenciada.pCarregaRegistro(const strIncEspGer : String; var arrChaves: TArrChaveNFReferenciaDocumentos);
  Var
    qryEspRef : TUniQuery;
begin
  qryEspRef := fCriaQuery;
  Try
    qryEspRef.Close;
    qryEspRef.SQL.Clear;
    qryEspRef.SQL.Add(' SELECT DISTINCT REF_ACESSO ');
    qryEspRef.SQL.Add('   FROM ESPREF ');
    qryEspRef.SQL.Add('  WHERE REF_ESPGER = :ESPGER ');
    qryEspRef.ParamByName('ESPGER').AsString := strIncEspGer;
    qryEspRef.Open;

    If (qryEspRef.IsEmpty) Then
      Exit;

    qryEspRef.First;
    While Not qryEspRef.Eof Do
    Begin
      SetLength(arrChaves, Length(arrChaves) + 1);
      arrChaves[Length(arrChaves) - 1] := qryEspRef.FieldByName('REF_ACESSO').AsString;
      qryEspRef.Next;
    End;
  Finally
    FreeAndNil(qryEspRef);
  End;
end;

procedure TEspelhoChaveReferenciada.pDeleta(const strIncEspGer: String);
  Var
    qryEspRef : TUniQuery;
begin
  qryEspRef := fCriaQuery;
  Try
    qryEspRef.Close;
    qryEspRef.SQL.Clear;
    qryEspRef.SQL.Add('DELETE FROM ESPREF WHERE REF_ESPGER = :ESPGER');
    qryEspRef.ParamByName('ESPGER').AsString := strIncEspGer;
    qryEspRef.ExecSQL;
  Finally
    FreeAndNil(qryEspRef);
  End;
end;

procedure TEspelhoChaveReferenciada.pSalva(const strIncEspGer : String; const arrChaves: TArrChaveNFReferenciaDocumentos);
  Var
    intCnt : Integer;
    qryEspRef : TUniQuery;
begin
  If (Length(arrChaves) = 0) Then
    Exit;

  qryEspRef := fCriaQuery;
  Try
    Self.pDeleta(strIncEspGer);

    qryEspRef.Close;
    qryEspRef.SQL.Clear;
    qryEspRef.SQL.Add('INSERT INTO ESPREF (AUTOINCREM, REF_ESPGER, REF_ACESSO) ');
    qryEspRef.SQL.Add('            VALUES (:AUTINC, :ESPGER, :ACESSO)');

    For intCnt := Low(arrChaves) To High(arrChaves) Do
    Begin
      qryEspRef.ParamByName('AUTINC').AsString := fRetAutoIncrem('ESPREF', VS_strCodEmp);
      qryEspRef.ParamByName('ESPGER').AsString := strIncEspGer;
      qryEspRef.ParamByName('ACESSO').AsString := arrChaves[intCnt];
      qryEspRef.ExecSQL;
    End;
  Finally
    FreeAndNil(qryEspRef);
  End;
end;

end.
