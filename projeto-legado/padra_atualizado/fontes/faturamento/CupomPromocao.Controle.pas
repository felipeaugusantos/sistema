unit CupomPromocao.Controle;

interface

uses
  System.Classes, Uni, Data.DB, System.Generics.Collections, untFuncFat,
  untFuncFatTypes, CupomPromocao.Classes, UniClientDataSet, Variants,
  untTypesSistema, System.StrUtils;

type
  TControleCupomPromocao = class
  strict private
    FQryValoresAcumulados               : TUniQuery;
    FlstValoresAcumuladosUtilizados     : TObjectList<TCupomValorAcumulado>;
    FlstCuponsGerados                   : TObjectList<TCupomGerado>;
    FlstValoresAcumulados               : TObjectList<TCupomValorAcumulado>;
    FImpSintetico                       : Boolean;
    FblnPermiteUtilizarCupomPromocional : Boolean;

    function fTipoClienteAtendeRegra(
      const AObjCupomPromocao: TCupomPromocao): Boolean;
    procedure pCarregaInformacoesValoresAcumuladosCupomPromocao(
      const strCodCli, strCodPro: String);

    procedure pGravarCupomGerado(
      const ACupomGerado: TCupomGerado);
    procedure pGravarCupomValorAcumulado(
      const ACupomValorAcumulado: TCupomValorAcumulado);
    procedure pAtualizarCupomValorAcumuladoUtilizado(
      const ACupomValorAcumuladoUtilizado: TCupomValorAcumulado);
    function fAtualizaERetornaSequencialCupomEmpresa(
      const ACodCpp, ACodEmp: String): String;
    function fRetornaSequencialCuponsPromocao(const ACodCpp: String): String;

    function fItemCadastradoCupomPromocao(AAutIncPromo,
      ACodIte: String): Boolean;
    function fItemEmPromocaoCupom(const AFatVenda: TFatVenda;
      const AArrItens: Array Of TDadosFechamento): TObjectList<TCupomPromocao>;
    procedure pGerarCupomPromocional(const AFatVenda: TFatVenda;
      const AArrItens: Array Of TDadosFechamento; const AblnOriF11: Boolean);
    procedure pDeduzirValorAcumuladoCupomPromocao(const strNumDoc, strEspDoc,
      strCodEmp: String);

    function fMontaCondicaoDeBusca(strNumDoc, strEspDoc, strCodEmp,
      strCodCli, strDtaIni, strDtaFin, strImpres, strCodPro: String): String;
    procedure pCarregaCupons(var qryCppGer: TUniQuery; strCondicao: String = '';
      blnAgrupar: Boolean = False);
    function fRetornaQuantidadeDeCupons(strNumDoc, strEspDoc, strCodEmp,
      strCodCli, strCodPro: String): Integer;
    function fCupomPromocional(strCodCpp: String): TCupomPromocao;
    procedure pCarregaCupomPromocional(qryCadCpp: TUniQuery; strCodCpp: String);
    procedure pPreencheObjCupomPromocional(objCupPro: TCupomPromocao;
      qryCapCpp: TUniQuery);
    procedure pImprimeCupom(objCupom: TCupomGerado; AQtde: Integer = 0);
    procedure pMarcaComoReimpresso(strAutInc, strImpresso: String);
    procedure pGravaLog(objCupom: TCupomGerado);
    function fCondicaoCupomEmVigencia: String;
    procedure pAddCondicaoSQL(strCampo, strValor: String;
      var strCondicao: String; strOpeCondicao: String = 'AND');
    procedure pAddCondicaoDataSQL(strCampo, dtaValor1, dtaValor2: String;
      var strCondicao: String);
    function fCupomImpressoNoPedido(const AFatVenda: TFatVenda; AOriF11: Boolean = False): Boolean;
    function fCondicaoNumFat(ANumDoc, AEspDoc, ACodEmp: String): String;

    procedure pCalculaNumeroCupons(const AObjCupomPromocao: TCupomPromocao;
      const AFatVenda: TFatVenda; const AblnOriF11: Boolean);
    procedure pCarregarDadosGravacao(const AFatVenda: TFatVenda;
      const AObjCupomPromocao: TCupomPromocao; const AblnOriF11: Boolean);
    procedure pGravarControleCupomPromocao;

  public
    constructor Create;
    destructor Destroy; override;

    class function New(): TControleCupomPromocao;

    function fRemoverCuponsNaoUtilizados(const ANumDoc, AEspDoc, ACodEmp: String): TControleCupomPromocao;

    procedure pCarregaListaCupons(strCondicao: String; blnAgrupar: Boolean = False);

    procedure pCarregaCDSReimpressao(var cdsCppGer: TUniClientDataSet; strNumDoc,
      strEspDoc, strCodEmp, strCodCli, strDtaIni, strDtaFin, strImpres, strCodPro: String);

    procedure pImprimeColecaoDeCupons(cdsCupons: TUniClientDataSet);

    procedure pImprimirCuponsGerados(const AFatVenda: TFatVenda;
      const AblnOriF11: Boolean = False);

    function fProcessarCupomPromocional(const AFatVenda: TFatVenda;
      const AArrItens: Array Of TDadosFechamento;
      const AblnCondicaoComplementar: Boolean=True;
      const AblnOriF11: Boolean = False): Boolean;

  end;

implementation

uses
  untFuncoesSimples, System.SysUtils, CupomPromocao.Impressao, untLogCpp;

{ TControleCupomPromocao }

constructor TControleCupomPromocao.Create;
begin
  FlstValoresAcumuladosUtilizados     := TObjectList<TCupomValorAcumulado>.Create;
  FlstCuponsGerados                   := TObjectList<TCupomGerado>.Create;
  FlstValoresAcumulados               := TObjectList<TCupomValorAcumulado>.Create;
  FQryValoresAcumulados               := fCriaQuery();
  FblnPermiteUtilizarCupomPromocional := False;

  FImpSintetico := (fCfgSis('IMPCPR', varString) = 'S');
end;

destructor TControleCupomPromocao.Destroy;
begin
  FreeAndNil(FlstValoresAcumuladosUtilizados);
  FreeAndNil(FlstCuponsGerados);
  FreeAndNil(FlstValoresAcumulados);
  FreeAndNil(FQryValoresAcumulados);
  inherited;
end;

function TControleCupomPromocao.fAtualizaERetornaSequencialCupomEmpresa(
  const ACodCpp, ACodEmp: String): String;
var
  qryDados : TUniQuery;
begin
  qryDados := fCriaQuery;
  Try
    qryDados.Close;
    qryDados.SQL.Text := 'UPDATE CPPEMP '
                       + '   SET CPP_QTDCPP = IFNULL(CPP_QTDCPP,0) + 1 '
                       + ' WHERE CPP_CODEMP = :CODEMP '
                       + '   AND CPP_SEQCPP = (SELECT AUTOINCREM FROM CADCPP '
                       + '                      WHERE CPP_CODCPP = :CODCPP) ';
    qryDados.ParamByName('CODEMP').AsString := ACodEmp;
    qryDados.ParamByName('CODCPP').AsString := ACodCpp;
    qryDados.ExecSQL;

    qryDados.Close;
    qryDados.SQL.Text := 'SELECT CPP_QTDCPP AS SEQUEN FROM CPPEMP '
                       + ' WHERE CPP_CODEMP = :CODEMP '
                       + '   AND CPP_SEQCPP = (SELECT AUTOINCREM FROM CADCPP '
                       + '                      WHERE CPP_CODCPP = :CODCPP) ';
    qryDados.ParamByName('CODEMP').AsString := ACodEmp;
    qryDados.ParamByName('CODCPP').AsString := ACodCpp;
    qryDados.Open;

    Result := ACodCpp + ACodEmp + qryDados.FieldByName('SEQUEN').AsString;
  Finally
    FreeAndNil(qryDados);
  End;
end;

procedure TControleCupomPromocao.pCarregarDadosGravacao(
  const AFatVenda: TFatVenda; const AObjCupomPromocao: TCupomPromocao;
  const AblnOriF11: Boolean);
var
  intContador                : Integer;
  objCupomGerado             : TCupomGerado;
  objValorAcumulado          : TCupomValorAcumulado;
  objValorAcumuladoUtilizado : TCupomValorAcumulado;
  dtaDataVenda               : TDateTime;
  dtaHoraVenda               : TDateTime;
begin
  If Not fTipoClienteAtendeRegra(AObjCupomPromocao) Then
    Exit;

  dtaDataVenda := VS_Date;
  dtaHoraVenda := fTime();
  FlstCuponsGerados.Clear;
  FlstValoresAcumulados.Clear;

  If AObjCupomPromocao.intTotCup > 0 Then
  Begin
    For intContador := 1 To AObjCupomPromocao.intTotCup Do
    Begin
      objCupomGerado := TCupomGerado.Create;
      objCupomGerado.dtaDtaEnt := dtaDataVenda;
      objCupomGerado.horHorEnt := dtaHoraVenda;

      if AblnOriF11 and AFatVenda.fTemNumOrc then
      begin
        objCupomGerado.strNumDoc := AFatVenda.strNumOrc;
        objCupomGerado.strEspDoc := AFatVenda.strEspOrc;
        objCupomGerado.strCodEmp := AFatVenda.strEmpOri;
        objCupomGerado.fltValDoc := AFatVenda.fltTotOri;
      end
      else
      begin
        objCupomGerado.strNumDoc := AFatVenda.strNumDoc;
        objCupomGerado.strEspDoc := AFatVenda.strEspDoc;
        objCupomGerado.fltValDoc := AFatVenda.fltTotPro;
        objCupomGerado.strCodEmp := VS_strCodEmp;
      end;

      objCupomGerado.strCodCli := AFatVenda.strCodCli;
      objCupomGerado.strCodCpp := AObjCupomPromocao.strCodPro;
      objCupomGerado.strEmpCpp := AObjCupomPromocao.strCodEmp;
      objCupomGerado.fltValUti := AObjCupomPromocao.fltValUti;
      objCupomGerado.fltValAcm := 0;

      if (not fClienteConsumidor(fRetNomCliente(AObjCupomPromocao.strCodCli), True, False)) then
        objCupomGerado.fltValAcm := AObjCupomPromocao.fltValAcm;

      objCupomGerado.strCodLay := AObjCupomPromocao.strCodLay;
      objCupomGerado.strImpCup := AObjCupomPromocao.strImpCup;

      objCupomGerado.strSequen := fAtualizaERetornaSequencialCupomEmpresa(
                                    objCupomGerado.strCodCpp, objCupomGerado.strCodEmp);

      objCupomGerado.strSeqPro := fRetornaSequencialCuponsPromocao(objCupomGerado.strCodCpp);

      FlstCuponsGerados.Add(objCupomGerado);
    End;
  End;

  If (AObjCupomPromocao.intTipPro = 0) And
     (AObjCupomPromocao.strAcmVal = 'S') Then
  Begin
    If (AObjCupomPromocao.fltValAcm <> 0) and
      (not fClienteConsumidor(fRetNomCliente(AObjCupomPromocao.strCodCli), True, False)) Then
    Begin
      objValorAcumulado := TCupomValorAcumulado.Create;
      objValorAcumulado.dtaDtaVen := dtaDataVenda;

      if AblnOriF11 and AFatVenda.fTemNumOrc then
      begin
        objValorAcumulado.strNumDoc := AFatVenda.strNumOrc;
        objValorAcumulado.strEspDoc := AFatVenda.strEspOrc;
        objValorAcumulado.strCodEmp := AFatVenda.strEmpOri;
        objValorAcumulado.fltValDoc := AFatVenda.fltTotOri;
      end
      else
      begin
        objValorAcumulado.strNumDoc := AFatVenda.strNumDoc;
        objValorAcumulado.strEspDoc := AFatVenda.strEspDoc;
        objValorAcumulado.fltValDoc := AFatVenda.fltTotPro;
        objValorAcumulado.strCodEmp := VS_strCodEmp;
      end;

      objValorAcumulado.strCodCli := AFatVenda.strCodCli;
      objValorAcumulado.strCodCpp := AObjCupomPromocao.strCodPro;
      objValorAcumulado.strEmpCpp := AObjCupomPromocao.strCodEmp;
      objValorAcumulado.fltValAcm := AObjCupomPromocao.fltValAcm;

      FlstValoresAcumulados.Add(objValorAcumulado);
    End;

    If AObjCupomPromocao.stlValoresAcoumuladosUtilizados.Count > 0 Then
    Begin
      For intContador := 0 To pred(AObjCupomPromocao.stlValoresAcoumuladosUtilizados.Count) do
      Begin
        objValorAcumuladoUtilizado := TCupomValorAcumulado.Create;
        objValorAcumuladoUtilizado.Autoincrem := AObjCupomPromocao.stlValoresAcoumuladosUtilizados[intContador];
        objValorAcumuladoUtilizado.dtaDtaUti  := dtaDataVenda;
        objValorAcumuladoUtilizado.horHorUti  := dtaHoraVenda;

        If (AObjCupomPromocao.intTotCup > 0) Then
        Begin
          if AblnOriF11 and AFatVenda.fTemNumOrc then
          begin
            objValorAcumuladoUtilizado.strDocUti  := AFatVenda.strNumOrc;
            objValorAcumuladoUtilizado.strEspUti  := AFatVenda.strEspOrc;
            objValorAcumuladoUtilizado.strEmpUti  := AFatVenda.strEmpOri;
          end
          else
          begin
            objValorAcumuladoUtilizado.strDocUti  := AFatVenda.strNumDoc;
            objValorAcumuladoUtilizado.strEspUti  := AFatVenda.strEspDoc;
            objValorAcumuladoUtilizado.strEmpUti  := VS_strCodEmp;
          end;
        End;

        FlstValoresAcumuladosUtilizados.Add(objValorAcumuladoUtilizado);
      End;
    End;
  End;
end;

function TControleCupomPromocao.fProcessarCupomPromocional(
  const AFatVenda: TFatVenda; const AArrItens: Array Of TDadosFechamento;
  const AblnCondicaoComplementar, AblnOriF11: Boolean): Boolean;
begin
  FblnPermiteUtilizarCupomPromocional := (fCfgSis('UTICPP', varBoolean)) And
                                         (AblnCondicaoComplementar) And
                                         (Assigned(AFatVenda));

  If (Not FblnPermiteUtilizarCupomPromocional) Then
    Exit(True);

  If (MatchStr(AFatVenda.strOpcDoc, ['VN','CP'])) Then
    pGerarCupomPromocional(AFatVenda, AArrItens, AblnOriF11)
  Else If (AFatVenda.strOpcDoc = 'DV') Then
    pDeduzirValorAcumuladoCupomPromocao(
      AFatVenda.strNumDoc, AFatVenda.strEspDoc, VS_strCodEmp);

  Result := True;
end;

procedure TControleCupomPromocao.pGravarControleCupomPromocao;
var
  objCupomGerado             : TCupomGerado;
  objValorAcumulado          : TCupomValorAcumulado;
  objValorAcumuladoUtilizado : TCupomValorAcumulado;
begin
  If FlstCuponsGerados.Count > 0 Then
  Begin
    For objCupomGerado in FlstCuponsGerados Do
      pGravarCupomGerado(objCupomGerado);
  End;

  If FlstValoresAcumulados.Count > 0 Then
  Begin
    For objValorAcumulado in FlstValoresAcumulados Do
      pGravarCupomValorAcumulado(objValorAcumulado);
  End;

  If FlstValoresAcumuladosUtilizados.Count > 0 Then
  Begin
    For objValorAcumuladoUtilizado in FlstValoresAcumuladosUtilizados Do
      pAtualizarCupomValorAcumuladoUtilizado(objValorAcumuladoUtilizado);
  End;
end;

function TControleCupomPromocao.fItemCadastradoCupomPromocao(AAutIncPromo,
  ACodIte: String): Boolean;
begin
  Result := (Not fEmptyStr(fCampoTabela('CPP_SEQCPP', 'CPPITE', ['CPP_SEQCPP', 'CPP_CODITE'], [AAutIncPromo, ACodIte], False)));
end;

function TControleCupomPromocao.fItemEmPromocaoCupom(const AFatVenda: TFatVenda;
  const AArrItens: array of TDadosFechamento): TObjectList<TCupomPromocao>;
var
  qryCupomPromo   : TUniQuery;
  objCupomPromo   : TCupomPromocao;
  intContador     : Integer;
  stlItens        : TStringList;
  fltValItem      : Double;
  strEmpresaCupom : String;
begin
  Result := TObjectList<TCupomPromocao>.Create;
  stlItens := TStringList.Create;
  qryCupomPromo := fCriaQuery;
  strEmpresaCupom := VS_strCodEmp;

  Try
    If Length(AArrItens) <= 0 Then
      Exit;

    For intContador := Low(AArrItens) To High(AArrItens) Do
    Begin
      If fConsideraEmpresaDoPedidoOrcamentoNoCupomPromocional Then
        strEmpresaCupom := AArrItens[intContador].strEmpOrc;

      If (fCfgSis('UTICPP', varBoolean, strEmpresaCupom)) Then
        stlItens.Add(AArrItens[intContador].strCodIte);
    End;

    If stlItens.Count <= 0 Then
      Exit;

    qryCupomPromo.Close;
    qryCupomPromo.SQL.Clear;

    qryCupomPromo.SQL.Add('SELECT ');
    qryCupomPromo.SQL.Add('       C.AUTOINCREM ');
    qryCupomPromo.SQL.Add('     , C.CPP_CODCPP ');
    qryCupomPromo.SQL.Add('     , C.CPP_TIPPRO ');
    qryCupomPromo.SQL.Add('     , C.CPP_VLCPP1 ');
    qryCupomPromo.SQL.Add('     , C.CPP_VLCPP2 ');
    qryCupomPromo.SQL.Add('     , C.CPP_NUMCUP ');
    qryCupomPromo.SQL.Add('     , C.CPP_DESCPP ');
    qryCupomPromo.SQL.Add('     , C.CPP_DESCRI ');
    qryCupomPromo.SQL.Add('     , C.CPP_TIPCLI ');
    qryCupomPromo.SQL.Add('     , C.CPP_CPCLCS ');
    qryCupomPromo.SQL.Add('     , C.CPP_ACMVAL ');
    qryCupomPromo.SQL.Add('     , C.CPP_CODEMP ');
    qryCupomPromo.SQL.Add('     , C.CPP_CODLAY ');
    qryCupomPromo.SQL.Add('     , C.CPP_ALLITE ');
    qryCupomPromo.SQL.Add('     , C.CPP_IMPCUP ');
    qryCupomPromo.SQL.Add('  FROM CADCPP C ');
    qryCupomPromo.SQL.Add(' INNER JOIN CPPEMP E ON(C.AUTOINCREM = E.CPP_SEQCPP) ');
    qryCupomPromo.SQL.Add(' WHERE CURRENT_DATE() BETWEEN C.CPP_DTAINI AND C.CPP_DTAFIN ');
    qryCupomPromo.SQL.Add('   AND E.CPP_CODEMP = :CODEMP ');
    qryCupomPromo.SQL.Add('   AND E.CPP_STATUS = "A" ');
    qryCupomPromo.SQL.Add('   AND NOT EXISTS(SELECT V.CPV_SEQCPP FROM CPPVEN V ');
    qryCupomPromo.SQL.Add('                   WHERE V.CPV_CODOPE = :CODOPE ');
    qryCupomPromo.SQL.Add('                     AND V.CPV_SEQCPP = C.AUTOINCREM) ');
    qryCupomPromo.SQL.Add(' ORDER BY ');
    qryCupomPromo.SQL.Add('       C.CPP_CODCPP ');

    qryCupomPromo.ParamByName('CODOPE').AsString := AFatVenda.strCodVen;
    qryCupomPromo.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryCupomPromo.Open;

    If qryCupomPromo.IsEmpty Then
      Exit;

    While Not qryCupomPromo.Eof Do
    Begin
      fltValItem := 0;

      For intContador := Low(AArrItens) To High(AArrItens) Do
      Begin
        If (qryCupomPromo.FieldByName('CPP_ALLITE').AsString = 'S') Then
        Begin
          If (Not fVerificaPDTemCupomGerado(AArrItens[intContador].strNumOrc, AArrItens[intContador].strEspOrc, AArrItens[intContador].strEmpOrc)) Then
            fltValItem := fltValItem + AArrItens[intContador].fltTotIte;
        End
        Else If fItemCadastradoCupomPromocao(qryCupomPromo.FieldByName('AUTOINCREM').AsString, AArrItens[intContador].strCodIte) Then
        Begin
          If (Not fVerificaPDTemCupomGerado(AArrItens[intContador].strNumOrc, AArrItens[intContador].strEspOrc, AArrItens[intContador].strEmpOrc)) Then
            fltValItem := fltValItem + AArrItens[intContador].fltTotIte;
        End;
      End;

      If fltValItem > 0 Then
      Begin
        objCupomPromo := TCupomPromocao.Create;
        objCupomPromo.strCodPro := qryCupomPromo.FieldByName('CPP_CODCPP').AsString;
        objCupomPromo.intTipPro := qryCupomPromo.FieldByName('CPP_TIPPRO').AsInteger;
        objCupomPromo.fltValPr1 := qryCupomPromo.FieldByName('CPP_VLCPP1').AsFloat;
        objCupomPromo.fltValPr2 := qryCupomPromo.FieldByName('CPP_VLCPP2').AsFloat;
        objCupomPromo.intNumCup := qryCupomPromo.FieldByName('CPP_NUMCUP').AsInteger;
        objCupomPromo.fltValTot := fltValItem;
        objCupomPromo.strCupTil := qryCupomPromo.FieldByName('CPP_DESCPP').AsString;
        objCupomPromo.strCupDes := qryCupomPromo.FieldByName('CPP_DESCRI').AsString;
        objCupomPromo.strTipCli := qryCupomPromo.FieldByName('CPP_TIPCLI').AsString;
        objCupomPromo.strCpcLcs := qryCupomPromo.FieldByName('CPP_CPCLCS').AsString;
        objCupomPromo.strAcmVal := qryCupomPromo.FieldByName('CPP_ACMVAL').AsString;
        objCupomPromo.strCodEmp := qryCupomPromo.FieldByName('CPP_CODEMP').AsString;
        objCupomPromo.strCodCli := AFatVenda.strCodCli;
        objCupomPromo.strCodLay := qryCupomPromo.FieldByName('CPP_CODLAY').AsString;
        objCupomPromo.strImpCup := qryCupomPromo.FieldByName('CPP_IMPCUP').AsString;
        Result.Add(objCupomPromo);
      End;

      qryCupomPromo.Next;
    End;
  Finally
    FreeAndNil(qryCupomPromo);
    FreeAndNil(stlItens);
  End;
end;

function TControleCupomPromocao.fRemoverCuponsNaoUtilizados(const ANumDoc,
  AEspDoc, ACodEmp: String): TControleCupomPromocao;
var
  qryRemover : TUniQuery;
begin
  Result := Self;

  If (fEmptyStr(ANumDoc)) Or
     (fEmptyStr(AEspDoc)) Or
     (fEmptyStr(ACodEmp)) Then
    Exit;

  qryRemover := fCriaQuery();
  Try
    qryRemover.Close;
    qryRemover.SQL.Text := 'DELETE FROM CPPVAC '
                         + ' WHERE CVA_NUMDOC = :NUMDOC '
                         + '   AND CVA_ESPDOC = :ESPDOC '
                         + '   AND CVA_CODEMP = :CODEMP '
                         + '   AND IFNULL(CVA_DTAUTI,"") = "" ';

    qryRemover.ParamByName('NUMDOC').AsString := ANumDoc;
    qryRemover.ParamByName('ESPDOC').AsString := AEspDoc;
    qryRemover.ParamByName('CODEMP').AsString := ACodEmp;
    qryRemover.ExecSQL;;
  Finally
    FreeAndNil(qryRemover);
  End;
end;

procedure TControleCupomPromocao.pAtualizarCupomValorAcumuladoUtilizado(
  const ACupomValorAcumuladoUtilizado: TCupomValorAcumulado);
var
  qryGravar : TUniQuery;
begin
  If Not Assigned(ACupomValorAcumuladoUtilizado) Then
    Exit;

  qryGravar := fCriaQuery;
  Try
    qryGravar.SQL.Text := 'UPDATE CPPVAC '
                        + '   SET CVA_DTAUTI = :DTAUTI '
                        + '     , CVA_HORUTI = :HORUTI ';

    If Not fEmptyStr(ACupomValorAcumuladoUtilizado.strDocUti) Then
    Begin
      qryGravar.SQL.Text := qryGravar.SQL.Text
                          + '     , CVA_DOCUTI = :DOCUTI '
                          + '     , CVA_ESPUTI = :ESPUTI '
                          + '     , CVA_EMPUTI = :EMPUTI ';
    End;

    qryGravar.SQL.Text := qryGravar.SQL.Text
                        + ' WHERE AUTOINCREM = :AUTINC ';

    qryGravar.ParamByName('AUTINC').AsString   := ACupomValorAcumuladoUtilizado.Autoincrem;
    qryGravar.ParamByName('DTAUTI').AsDateTime := ACupomValorAcumuladoUtilizado.dtaDtaUti;
    qryGravar.ParamByName('HORUTI').AsDateTime := ACupomValorAcumuladoUtilizado.horHorUti;

    If Not fEmptyStr(ACupomValorAcumuladoUtilizado.strDocUti) Then
    Begin
      qryGravar.ParamByName('DOCUTI').AsString   := ACupomValorAcumuladoUtilizado.strDocUti;
      qryGravar.ParamByName('ESPUTI').AsString   := ACupomValorAcumuladoUtilizado.strEspUti;
      qryGravar.ParamByName('EMPUTI').AsString   := ACupomValorAcumuladoUtilizado.strEmpUti;
    End;

    qryGravar.ExecSQL;
  Finally
    FreeAndNil(qryGravar);
  End;
end;

procedure TControleCupomPromocao.pGravarCupomGerado(
  const ACupomGerado: TCupomGerado);
var
  qryGravar : TUniQuery;
begin
  If Not Assigned(ACupomGerado) Then
    Exit;

  qryGravar := fCriaQuery;
  Try
    qryGravar.SQL.Text := 'INSERT INTO CPPGER ( '
                        + '       AUTOINCREM '
                        + '     , CPG_DTAENT '
                        + '     , CPG_HORENT '
                        + '     , CPG_SEQUEN '
                        + '     , CPG_NUMDOC '
                        + '     , CPG_ESPDOC '
                        + '     , CPG_VALDOC '
                        + '     , CPG_CODCLI '
                        + '     , CPG_CODEMP '
                        + '     , CPG_CODCPP '
                        + '     , CPG_EMPCPP '
                        + '     , CPG_VALUTI '
                        + '     , CPG_CODLAY '
                        + '     , CPG_TIPIMP '
                        + '     , CPG_VALACM '
                        + '     , CPG_SEQPRO '
                        + ') VALUES ( '
                        + '       :AUTOINCREM '
                        + '     , :CPG_DTAENT '
                        + '     , :CPG_HORENT '
                        + '     , :CPG_SEQUEN '
                        + '     , :CPG_NUMDOC '
                        + '     , :CPG_ESPDOC '
                        + '     , :CPG_VALDOC '
                        + '     , :CPG_CODCLI '
                        + '     , :CPG_CODEMP '
                        + '     , :CPG_CODCPP '
                        + '     , :CPG_EMPCPP '
                        + '     , :CPG_VALUTI '
                        + '     , :CPG_CODLAY '
                        + '     , :CPG_TIPIMP '
                        + '     , :CPG_VALACM '
                        + '     , :CPG_SEQPRO)';

    qryGravar.ParamByName('AUTOINCREM').AsString   := fRetAutoIncrem('CPPGER', VS_strCodEmp);
    qryGravar.ParamByName('CPG_DTAENT').AsDateTime := ACupomGerado.dtaDtaEnt;
    qryGravar.ParamByName('CPG_HORENT').AsDateTime := ACupomGerado.horHorEnt;
    qryGravar.ParamByName('CPG_SEQUEN').AsString   := ACupomGerado.strSequen;
    qryGravar.ParamByName('CPG_NUMDOC').AsString   := ACupomGerado.strNumDoc;
    qryGravar.ParamByName('CPG_ESPDOC').AsString   := ACupomGerado.strEspDoc;
    qryGravar.ParamByName('CPG_VALDOC').AsFloat    := ACupomGerado.fltValDoc;
    qryGravar.ParamByName('CPG_CODCLI').AsString   := ACupomGerado.strCodCli;
    qryGravar.ParamByName('CPG_CODEMP').AsString   := ACupomGerado.strCodEmp;
    qryGravar.ParamByName('CPG_CODCPP').AsString   := ACupomGerado.strCodCpp;
    qryGravar.ParamByName('CPG_EMPCPP').AsString   := ACupomGerado.strEmpCpp;
    qryGravar.ParamByName('CPG_VALUTI').AsFloat    := ACupomGerado.fltValUti;
    qryGravar.ParamByName('CPG_CODLAY').AsString   := ACupomGerado.strCodLay;
    qryGravar.ParamByName('CPG_TIPIMP').AsString   := IIF(fCfgSis('PROICP',varString) = '1', 'S', 'N');
    qryGravar.ParamByName('CPG_VALACM').AsFloat    := ACupomGerado.fltValAcm;
    qryGravar.ParamByName('CPG_SEQPRO').AsString   := ACupomGerado.strSeqPro;
    qryGravar.ExecSQL;
  Finally
    FreeAndNil(qryGravar);
  End;
end;

procedure TControleCupomPromocao.pGravarCupomValorAcumulado(
  const ACupomValorAcumulado: TCupomValorAcumulado);
var
  qryGravar : TUniQuery;
begin
  If Not Assigned(ACupomValorAcumulado) Then
    Exit;

  qryGravar := fCriaQuery;
  Try
    qryGravar.SQL.Text := 'INSERT INTO CPPVAC ( '
                        + '       AUTOINCREM '
                        + '     , CVA_DTAVEN '
                        + '     , CVA_NUMDOC '
                        + '     , CVA_ESPDOC '
                        + '     , CVA_CODEMP '
                        + '     , CVA_VALDOC '
                        + '     , CVA_CODCLI '
                        + '     , CVA_CODCPP '
                        + '     , CVA_EMPCPP '
                        + '     , CVA_VALACM '
                        + ') VALUES ( '
                        + '       :AUTOINCREM '
                        + '     , :CVA_DTAVEN '
                        + '     , :CVA_NUMDOC '
                        + '     , :CVA_ESPDOC '
                        + '     , :CVA_CODEMP '
                        + '     , :CVA_VALDOC '
                        + '     , :CVA_CODCLI '
                        + '     , :CVA_CODCPP '
                        + '     , :CVA_EMPCPP '
                        + '     , :CVA_VALACM) ';

    ACupomValorAcumulado.Autoincrem                := fRetAutoIncrem('CPPVAC', VS_strCodEmp);
    qryGravar.ParamByName('AUTOINCREM').AsString   := ACupomValorAcumulado.Autoincrem;
    qryGravar.ParamByName('CVA_DTAVEN').AsDateTime := ACupomValorAcumulado.dtaDtaVen;
    qryGravar.ParamByName('CVA_NUMDOC').AsString   := ACupomValorAcumulado.strNumDoc;
    qryGravar.ParamByName('CVA_ESPDOC').AsString   := ACupomValorAcumulado.strEspDoc;
    qryGravar.ParamByName('CVA_VALDOC').AsFloat    := ACupomValorAcumulado.fltValDoc;
    qryGravar.ParamByName('CVA_CODCLI').AsString   := ACupomValorAcumulado.strCodCli;
    qryGravar.ParamByName('CVA_CODEMP').AsString   := ACupomValorAcumulado.strCodEmp;
    qryGravar.ParamByName('CVA_CODCPP').AsString   := ACupomValorAcumulado.strCodCpp;
    qryGravar.ParamByName('CVA_EMPCPP').AsString   := ACupomValorAcumulado.strEmpCpp;
    qryGravar.ParamByName('CVA_VALACM').AsFloat    := ACupomValorAcumulado.fltValAcm;
    qryGravar.ExecSQL;
  Finally
    FreeAndNil(qryGravar);
  End;
end;

class function TControleCupomPromocao.New: TControleCupomPromocao;
begin
  Result := Self.Create;
end;

function TControleCupomPromocao.fTipoClienteAtendeRegra(
  const AObjCupomPromocao: TCupomPromocao): Boolean;
begin
  Result := False;

  If (AObjCupomPromocao.strCpcLcs = 'S') And
     (fClienteConsumidor(fRetNomCliente(AObjCupomPromocao.strCodCli), True, False)) Then
    Exit;

  If (Not fClientePessoaFisica(AObjCupomPromocao.strCodCli)) And
     (AObjCupomPromocao.strTipCli = 'F') Then
    Exit;

  If (fClientePessoaFisica(AObjCupomPromocao.strCodCli)) And
     (AObjCupomPromocao.strTipCli = 'J') Then
    Exit;

  Result := True;
end;

procedure TControleCupomPromocao.pCalculaNumeroCupons(
  const AObjCupomPromocao: TCupomPromocao;
  const AFatVenda: TFatVenda; const AblnOriF11: Boolean);
begin
  AObjCupomPromocao.intTotCup := 0;

  If Not fTipoClienteAtendeRegra(AObjCupomPromocao) Then
    Exit;

  If fCupomImpressoNoPedido(AFatVenda, AblnOriF11) Then
    Exit;

  If AObjCupomPromocao.intTipPro = 0 Then
  Begin
    AObjCupomPromocao.fltSldUti := 0;

    If (AObjCupomPromocao.strAcmVal = 'S') and
      (not fClienteConsumidor(fRetNomCliente(AObjCupomPromocao.strCodCli), True, False))  Then
    Begin
      pCarregaInformacoesValoresAcumuladosCupomPromocao(
        AObjCupomPromocao.strCodCli,
        AObjCupomPromocao.strCodPro);

      FQryValoresAcumulados.First;
      AObjCupomPromocao.stlValoresAcoumuladosUtilizados.Clear;

      While Not FQryValoresAcumulados.Eof Do
      Begin
        AObjCupomPromocao.fltSldUti := AObjCupomPromocao.fltSldUti
                                     + FQryValoresAcumulados.FieldByName('CVA_VALACM').AsFloat;

        AObjCupomPromocao.stlValoresAcoumuladosUtilizados.Add(FQryValoresAcumulados.FieldByName('AUTOINCREM').AsString);

        FQryValoresAcumulados.Next;
      End;
    End;

    AObjCupomPromocao.intTotCup := Trunc(AObjCupomPromocao.fltValTot + AObjCupomPromocao.fltSldUti) DIV Trunc(AObjCupomPromocao.fltValPr1);
  End
  Else If AObjCupomPromocao.intTipPro = 1 Then
  Begin
    If AObjCupomPromocao.fltValTot >= AObjCupomPromocao.fltValPr2 Then
    Begin
      AObjCupomPromocao.intTotCup := AObjCupomPromocao.intNumCup;
    End;
  End;
end;

procedure TControleCupomPromocao.pCarregaInformacoesValoresAcumuladosCupomPromocao(
  const strCodCli, strCodPro: String);
begin
  FQryValoresAcumulados.Close;
  FQryValoresAcumulados.SQL.Text := 'SELECT '
                                  + '       AUTOINCREM '
                                  + '     , CVA_VALACM '
                                  + '  FROM CPPVAC '
                                  + ' WHERE IFNULL(CVA_DTAUTI,"") = "" '
                                  + '   AND CVA_CODCLI = :CODCLI '
                                  + '   AND CVA_CODCPP = :CODCPP '
                                  + ' ORDER BY '
                                  + '       CVA_DTAVEN ';

  FQryValoresAcumulados.ParamByName('CODCLI').AsString := strCodCli;
  FQryValoresAcumulados.ParamByName('CODCPP').AsString := strCodPro;
  FQryValoresAcumulados.Open;
end;

procedure TControleCupomPromocao.pCarregaListaCupons(strCondicao: String;
  blnAgrupar: Boolean);
  Var
    qryCppGer: TUniQuery;
    objCupom: TCupomGerado;
begin
  qryCppGer := fCriaQuery;

  Try
    FlstCuponsGerados.Clear;
    pCarregaCupons(qryCppGer, strCondicao, blnAgrupar);

    If (qryCppGer.IsEmpty) Then
      Exit;

    While (Not qryCppGer.Eof) Do
    Begin
      objCupom := TCupomGerado.Create;

      objCupom.fltValDoc  := qryCppGer.FieldByName('CPG_VALDOC').AsFloat;
      objCupom.fltValUti  := qryCppGer.FieldByName('CPG_VALUTI').AsFloat;
      objCupom.fltValAcm  := qryCppGer.FieldByName('CPG_VALACM').AsFloat;
      objCupom.Autoincrem := qryCppGer.FieldByName('AUTOINCREM').AsString;
      objCupom.strNumDoc  := qryCppGer.FieldByName('CPG_NUMDOC').AsString;
      objCupom.strEspDoc  := qryCppGer.FieldByName('CPG_ESPDOC').AsString;
      objCupom.strCodEmp  := qryCppGer.FieldByName('CPG_CODEMP').AsString;
      objCupom.strCodCli  := qryCppGer.FieldByName('CPG_CODCLI').AsString;
      objCupom.strCodCpp  := qryCppGer.FieldByName('CPG_CODCPP').AsString;
      objCupom.strDesCpp  := qryCppGer.FieldByName('CPP_DESCPP').AsString;
      objCupom.strEmpCpp  := qryCppGer.FieldByName('CPG_EMPCPP').AsString;
      objCupom.strSequen  := qryCppGer.FieldByName('CPG_SEQUEN').AsString;
      objCupom.dtaDtaEnt  := qryCppGer.FieldByName('CPG_DTAENT').AsDateTime;
      objCupom.horHorEnt  := qryCppGer.FieldByName('CPG_HORENT').AsDateTime;
      objCupom.strCliCpf  := qryCppGer.FieldByName('CPG_CLICPF').AsString;
      objCupom.strImpres  := qryCppGer.FieldByName('CPG_TIPIMP').AsString;
      objCupom.strCodLay  := qryCppGer.FieldByName('CPG_CODLAY').AsString;
      objCupom.strSeqPro  := qryCppGer.FieldByName('CPG_SEQPRO').AsString;
      objCupom.strImpCup  := qryCppGer.FieldByName('CPP_IMPCUP').AsString;

      FlstCuponsGerados.Add(objCupom);
      qryCppGer.Next;
    End;
  Finally
    FreeAndNil(qryCppGer);
  End;
end;

procedure TControleCupomPromocao.pDeduzirValorAcumuladoCupomPromocao(
  const strNumDoc, strEspDoc, strCodEmp: String);
var
  qryDocDev,
  qryValoresAcumulados       : TUniQuery;
  objCupomValorAcumulado,
  objValorAcumuladoUtilizado : TCupomValorAcumulado;
begin
  If (Not fCfgSis('IDVCPR', varBoolean))  Then
    Exit;

  qryDocDev            := fCriaQuery;
  qryValoresAcumulados := fCriaQuery;
  Try
    qryDocDev.Close;
    qryDocDev.SQL.Text := 'SELECT '
                        + '       D.DET_DOCDEV      AS DOCORI '
                        + '     , D.DET_ESPDEV      AS ESPORI '
                        + '     , D.DET_EMPDEV      AS EMPORI '
                        + '     , G.GER_DTAENT      AS DTADEV '
                        + '     , G.GER_HORENT      AS HORDEV '
                        + '     , G.GER_NUMDOC      AS DOCDEV '
                        + '     , G.GER_ESPDOC      AS ESPDEV '
                        + '     , G.GER_CODEMP      AS EMPDEV '
                        + '     , SUM(D.DET_UNITAR) AS TOTDEV '
                        + '     , A.CVA_CODCLI      AS CODCLI '
                        + '     , A.CVA_CODCPP      AS CODCPP '
                        + '     , A.CVA_CODEMP      AS EMPCPP '
                        + '     , A.CVA_VALACM      AS VALACM '
                        + '     , P.CPP_ACMVAL      AS ACMVAL '
                        + '     , (SELECT SUM(T.DET_UNITAR) FROM MOVDET T '
                        + '         INNER JOIN CPPITE E ON E.CPP_CODITE = T.DET_CODITE '
                        + '         WHERE E.CPP_SEQCPP = P.AUTOINCREM '
                        + '           AND T.DET_NUMDOC = D.DET_DOCDEV '
                        + '           AND T.DET_ESPDOC = D.DET_ESPDEV '
                        + '           AND T.DET_CODEMP = D.DET_EMPDEV) AS TOTVND '
                        + '  FROM MOVGER G '
                        + ' INNER JOIN MOVDET D ON D.DET_SEQGER = G.AUTOINCREM '
                        + '  LEFT JOIN FATDOR R ON R.FDO_NUMFAT = D.DET_DOCDEV '
                        + '                    AND R.FDO_TIPFAT = D.DET_ESPDEV '
                        + '                    AND R.FDO_EMPFAT = D.DET_EMPDEV '
                        + '  LEFT JOIN FATDOR O ON O.FDO_NUMFAT = R.FDO_NUMDOC '
                        + '                    AND O.FDO_TIPFAT = R.FDO_ESPDOC '
                        + '                    AND O.FDO_EMPFAT = R.FDO_CODEMP '
                        + '  LEFT JOIN MOVTRI M ON M.DET_SEQGER = D.AUTOINCREM '
                        + '  LEFT JOIN MOVDET F ON F.AUTOINCREM = M.DET_INCDEV '
                        + '  LEFT JOIN MOVTRI H ON H.DET_SEQGER = F.AUTOINCREM '
                        + '  LEFT JOIN MOVDET J ON J.AUTOINCREM = H.DET_INCFUT '
                        + '  LEFT JOIN CPPVAC A ON (A.CVA_NUMDOC = IFNULL(O.FDO_NUMDOC, D.DET_DOCDEV) '
                        + '                    AND  A.CVA_ESPDOC = IFNULL(O.FDO_ESPDOC, D.DET_ESPDEV) '
                        + '                    AND  A.CVA_CODEMP = IFNULL(O.FDO_CODEMP, D.DET_EMPDEV) '
                        + '                    AND  G.GER_ESPDOC = :ESPDOC) '
                        + '                     OR (A.CVA_NUMDOC = IFNULL(J.DET_NUM_PD, F.DET_NUMDOC) '
                        + '                    AND  A.CVA_ESPDOC = IFNULL(J.DET_ESP_PD, F.DET_ESPDOC) '
                        + '                    AND  A.CVA_CODEMP = IFNULL(J.DET_EMP_PD, F.DET_CODEMP) '
                        + '                    AND  G.GER_ESPDOC = :ESPDOC) '
                        + '  LEFT JOIN CPPITE I ON I.CPP_CODITE = D.DET_CODITE '
                        + '  LEFT JOIN CADCPP P ON P.AUTOINCREM = I.CPP_SEQCPP '
                        + ' WHERE P.CPP_CODCPP = A.CVA_CODCPP '
                        + '   AND G.GER_NUMDOC = :NUMDOC '
                        + '   AND G.GER_CODEMP = :CODEMP '
                        + ' GROUP BY '
                        + '       D.DET_DOCDEV '
                        + '     , D.DET_ESPDEV '
                        + '     , D.DET_EMPDEV '
                        + '     , G.GER_NUMDOC '
                        + '     , G.GER_ESPDOC '
                        + '     , G.GER_CODEMP '
                        + '     , A.CVA_CODCLI '
                        + '     , A.CVA_CODCPP '
                        + '     , A.CVA_CODEMP '
                        + '     , A.CVA_VALDOC '
                        + '     , A.CVA_VALACM '
                        + '     , P.CPP_ACMVAL ';

    qryDocDev.ParamByName('NUMDOC').AsString := strNumDoc;
    qryDocDev.ParamByName('ESPDOC').AsString := strEspDoc;
    qryDocDev.ParamByName('CODEMP').AsString := strCodemp;
    qryDocDev.Open;

    If (qryDocDev.IsEmpty) Or
       (qryDocDev.FieldByName('ACMVAL').AsString <> 'S') Then
      Exit;

    pCarregaInformacoesValoresAcumuladosCupomPromocao(
      qryDocDev.FieldByName('CODCLI').AsString,
      qryDocDev.FieldByName('CODCPP').AsString);

    objCupomValorAcumulado     := TCupomValorAcumulado.Create;
    objValorAcumuladoUtilizado := TCupomValorAcumulado.Create;
    Try
      objCupomValorAcumulado.dtaDtaVen := qryDocDev.FieldByName('DTADEV').AsDateTime;
      objCupomValorAcumulado.strNumDoc := qryDocDev.FieldByName('DOCDEV').AsString;
      objCupomValorAcumulado.strEspDoc := qryDocDev.FieldByName('ESPDEV').AsString;
      objCupomValorAcumulado.strCodEmp := qryDocDev.FieldByName('EMPDEV').AsString;
      objCupomValorAcumulado.strCodCli := qryDocDev.FieldByName('CODCLI').AsString;
      objCupomValorAcumulado.fltValDoc := qryDocDev.FieldByName('TOTVND').AsFloat;
      objCupomValorAcumulado.strCodCpp := qryDocDev.FieldByName('CODCPP').AsString;
      objCupomValorAcumulado.strEmpCpp := qryDocDev.FieldByName('EMPCPP').AsString;
      objCupomValorAcumulado.fltValAcm := (qryDocDev.FieldByName('TOTDEV').AsFloat * (-1))
                                        +  FQryValoresAcumulados.FieldByName('CVA_VALACM').AsFloat;

      pGravarCupomValorAcumulado(objCupomValorAcumulado);

      objValorAcumuladoUtilizado.Autoincrem := FQryValoresAcumulados.FieldByName('AUTOINCREM').AsString;
      objValorAcumuladoUtilizado.dtaDtaUti  := qryDocDev.FieldByName('DTADEV').AsDateTime;
      objValorAcumuladoUtilizado.horHorUti  := qryDocDev.FieldByName('HORDEV').AsDateTime;
      objValorAcumuladoUtilizado.strDocUti  := qryDocDev.FieldByName('DOCDEV').AsString;
      objValorAcumuladoUtilizado.strEspUti  := qryDocDev.FieldByName('ESPDEV').AsString;
      objValorAcumuladoUtilizado.strEmpUti  := qryDocDev.FieldByName('EMPDEV').AsString;

      pAtualizarCupomValorAcumuladoUtilizado(objValorAcumuladoUtilizado);
    Finally
      FreeAndNil(objCupomValorAcumulado);
      FreeAndNil(objValorAcumuladoUtilizado);
    End;
  Finally
    FreeAndNil(qryDocDev);
    FreeAndNil(qryValoresAcumulados);
  End;
end;

procedure TControleCupomPromocao.pCarregaCupons(Var qryCppGer: TUniQuery;
  strCondicao: String = ''; blnAgrupar: Boolean = False);
begin
  qryCppGer.Close;
  qryCppGer.SQL.Clear;
  qryCppGer.SQL.Add(' SELECT CPPGER.*, CADCPP.CPP_DESCPP, CADCPP.CPP_IMPCUP ');
  qryCppGer.SQL.Add(' FROM CPPGER ');
  qryCppGer.SQL.Add(' INNER JOIN CADCPP ON CPG_CODCPP = CPP_CODCPP ');
  qryCppGer.SQL.Add(strCondicao);

  qryCppGer.SQL.Add(' AND (CURRENT_DATE() BETWEEN CPP_DTAINI AND CPP_DTAFIN) ');

  If (blnAgrupar) Then
  Begin
    qryCppGer.SQL.Text := qryCppGer.SQL.Text +#13+
      'GROUP BY CPG_CODCPP, CPG_NUMDOC, CPG_ESPDOC, CPG_CODEMP, CPG_CODCLI';
  End;

  qryCppGer.Open;
end;

function TControleCupomPromocao.fMontaCondicaoDeBusca(strNumDoc, strEspDoc,
  strCodEmp, strCodCli, strDtaIni, strDtaFin, strImpres, strCodPro: String): String;
  Var
    strCondicao: String;
begin
  pAddCondicaoSQL('CPG_NUMDOC', strNumDoc, strCondicao);
  pAddCondicaoSQL('CPG_ESPDOC', strEspDoc, strCondicao);
  pAddCondicaoSQL('CPG_CODEMP', strCodEmp, strCondicao);

  if (not fEmptyStr(strCondicao)) and fCfgSis('CPPF11', varBoolean) then
  begin
    strCondicao := '((' + strCondicao + ')';
    pAddCondicaoSQL(EmptyStr, fCondicaoNumFat(strNumDoc, strEspDoc, strCodEmp), strCondicao, 'OR');
    strCondicao := strCondicao + ')';
  end;

  pAddCondicaoSQL('CPG_CODCLI', strCodCli, strCondicao);
  pAddCondicaoSQL('CPG_TIPIMP', strImpres, strCondicao);
  pAddCondicaoSQL('CPG_CODCPP', strCodPro, strCondicao);

  If Not fEmptyStr(strDtaIni) Then
    pAddCondicaoDataSQL('CPG_DTAENT', strDtaIni, strDtaFin, strCondicao);

  pAddCondicaoSQL(EmptyStr, fCondicaoCupomEmVigencia, strCondicao);

  Result := ' WHERE ' + strCondicao;
end;

function TControleCupomPromocao.fCondicaoCupomEmVigencia: String;
begin
  Result := 'EXISTS                                     '+
            '  (SELECT                                  '+
            '    CPP_CODCPP                             '+
            '  FROM                                     '+
            '    CADCPP                                 '+
            '    INNER JOIN CPPEMP                      '+
            '      ON CPP_SEQCPP = CADCPP.AUTOINCREM    '+
            '  WHERE CPP_CODCPP = CPG_CODCPP            '+
            '    AND CPP_STATUS = "A")                  ';
end;

function TControleCupomPromocao.fCondicaoNumFat(ANumDoc, AEspDoc, ACodEmp: String): String;
begin
  Result := ' EXISTS                                                   '+
            '  (SELECT C.AUTOINCREM FROM CPPGER C                      '+
            '   INNER JOIN FATDOR FAT ON FAT.FDO_NUMDOC = C.CPG_NUMDOC '+
            '                        AND FAT.FDO_ESPDOC = C.CPG_ESPDOC '+
            '                        AND FAT.FDO_CODEMP = C.CPG_CODEMP '+
            '   INNER JOIN FATDOR F ON F.FDO_NUMDOC = FAT.FDO_NUMFAT   '+
            '                        AND F.FDO_ESPDOC = FAT.FDO_TIPFAT '+
            '                        AND F.FDO_CODEMP = FAT.FDO_EMPFAT '+
            '   WHERE C.AUTOINCREM = CPPGER.AUTOINCREM                 '+
            '     AND F.FDO_NUMFAT = ' + QuotedStr(ANumDoc)             +
            '     AND F.FDO_TIPFAT = ' + QuotedStr(AEspDoc)             +
            '     AND F.FDO_EMPFAT = ' + QuotedStr(ACodEmp) + ')       '+
            ' OR EXISTS                                                '+
            '   (SELECT C.AUTOINCREM FROM CPPGER C                     '+
            '   INNER JOIN FATDOR F ON F.FDO_NUMDOC = C.CPG_NUMDOC     '+
            '                        AND F.FDO_ESPDOC = C.CPG_ESPDOC   '+
            '                        AND F.FDO_CODEMP = C.CPG_CODEMP   '+
            '   WHERE C.AUTOINCREM = CPPGER.AUTOINCREM                 '+
            '     AND F.FDO_NUMFAT = ' + QuotedStr(ANumDoc)             +
            '     AND F.FDO_TIPFAT = ' + QuotedStr(AEspDoc)             +
            '     AND F.FDO_EMPFAT = ' + QuotedStr(ACodEmp) + ')       ';
end;

procedure TControleCupomPromocao.pAddCondicaoDataSQL(strCampo, dtaValor1,
  dtaValor2: String; var strCondicao: String);
begin
  If (Not fEmptyStr(strCondicao)) Then
    strCondicao := strCondicao + ' AND ';

  strCondicao := strCondicao + strCampo + ' BETWEEN '+fCurrentDate(StrToDate(dtaValor1))+' AND ' + fCurrentDate(StrToDate(dtaValor2));
end;

procedure TControleCupomPromocao.pAddCondicaoSQL(strCampo, strValor: String;
  Var strCondicao: String; strOpeCondicao: String = 'AND');
begin
  If (fEmptyStr(strValor)) Then
    Exit;

  If (strCampo = 'CPG_TIPIMP') And (strValor = 'T') Then
    Exit;

  If (Not fEmptyStr(strCondicao)) Then
    strCondicao := strCondicao + ' ' + strOpeCondicao + ' ';

  If (strCampo = 'CPG_TIPIMP') Then
  Begin
    If (strValor = 'S') Then
      strCondicao := strCondicao + strCampo + ' <> "N" '
    Else If (strValor = 'N') Then
      strCondicao := strCondicao + strCampo + ' = "N" ';
  End
  Else
  Begin
    If (Not fEmptyStr(strCampo)) Then
      strCondicao := strCondicao + strCampo + ' = ' + QuotedStr(strValor)
    Else
      strCondicao := strCondicao + strValor;
    End;
end;

procedure TControleCupomPromocao.pCarregaCDSReimpressao(Var cdsCppGer: TUniClientDataSet;
  strNumDoc, strEspDoc, strCodEmp, strCodCli, strDtaIni, strDtaFin, strImpres, strCodPro: String);
  Var
    objCupom: TCupomGerado;
    strCondicao: String;
    strDocumen: String;
    strCliente: String;
    dteDataHor: TDateTime;
    intQuantCp: Integer;
    strCliCpf: String;
begin
  strCondicao := fMontaCondicaoDeBusca(strNumDoc, strEspDoc, strCodEmp, strCodCli, strDtaIni, strDtaFin, strImpres, strCodPro);
  pCarregaListaCupons(strCondicao);
  intQuantCp := 1;

  cdsCppGer.EmptyDataSet;

  For objCupom In FlstCuponsGerados Do
  Begin
    strDocumen := objCupom.strNumDoc + '-' + objCupom.strEspDoc + '-' + objCupom.strCodEmp;
    strCliente := objCupom.strCodCli + '-' + fRetNomCliente(objCupom.strCodCli);
    dteDataHor := objCupom.dtaDtaEnt + objCupom.horHorEnt;
    strCliCpf  := IIF(fEmptyStr(objCupom.strCliCpf), EmptyStr, objCupom.strCliCpf + '-' + fRetNomCliente(objCupom.strCliCpf));

    If FImpSintetico Then
    Begin
      If (cdsCppGer.Locate('DOCUMENTO;PROMOCAO', VarArrayOf([strDocumen, Trim(objCupom.strCodCpp + ' - ' + objCupom.strDesCpp)]), [])) Then
        Continue;

      intQuantCp := fRetornaQuantidadeDeCupons(objCupom.strNumDoc,
                                               objCupom.strEspDoc,
                                               objCupom.strCodEmp,
                                               objCupom.strCodCli,
                                               objCupom.strCodCpp);
    End;

    cdsCppGer.Append;
    cdsCppGer.FieldByName('VALOR'     ).AsFloat    := objCupom.fltValDoc;
    cdsCppGer.FieldByName('DOCUMENTO' ).AsString   := strDocumen;
    cdsCppGer.FieldByName('CLIENTE'   ).AsString   := strCliente;
    cdsCppGer.FieldByName('DATA'      ).AsDateTime := dteDataHor;
    cdsCppGer.FieldByName('QUANTIDADE').AsInteger  := intQuantCp;
    cdsCppGer.FieldByName('CLICPF'    ).AsString   := strCliCpf;
    cdsCppGer.FieldByName('IMPRESSO'  ).AsString   := objCupom.strImpres;
    cdsCppGer.FieldByName('CUPOM'     ).AsString   := objCupom.strSequen;
    cdsCppGer.FieldByName('PROMOCAO'  ).AsString   := Trim(objCupom.strCodCpp + ' - ' + objCupom.strDesCpp);
    cdsCppGer.FieldByName('QTDORI'    ).AsInteger  := intQuantCp;
    cdsCppGer.FieldByName('SEQPRO'    ).AsString   := objCupom.strSeqPro;
    cdsCppGer.Post;
  End;

  cdsCppGer.First;
end;

function TControleCupomPromocao.fRetornaSequencialCuponsPromocao(const ACodCpp: String): String;
var
  LQry : TUniQuery;
begin
  LQry := fCriaQuery;

  try
    LQry.SQL.Text := 'SELECT SUM(IFNULL(CPP_QTDCPP,0)) AS QTDCPP FROM CPPEMP '
                       + ' WHERE CPP_SEQCPP = (SELECT AUTOINCREM FROM CADCPP '
                       + '                      WHERE CPP_CODCPP = :CODCPP) ';
    LQry.ParamByName('CODCPP').AsString := ACodCpp;
    LQry.Open;

    Result := LQry.FieldByName('QTDCPP').AsString;
  finally
    FreeAndNil(LQry);
  end;
end;

function TControleCupomPromocao.fRetornaQuantidadeDeCupons(strNumDoc, strEspDoc,
  strCodEmp, strCodCli, strCodPro: String): Integer;
  Var
    qryCppGer: TUniQuery;
begin
  Result := 0;
  qryCppGer := fCriaQuery;

  Try
    qryCppGer.Close;
    qryCppGer.SQL.Clear;
    qryCppGer.SQL.Text := ' SELECT                       '+
                          '   COUNT(CPG_CODCPP) AS QTDE  '+
                          ' FROM                         '+
                          '   CPPGER                     '+
                          ' WHERE                        '+
                          '   CPG_NUMDOC = :NUMDOC AND   '+
                          '   CPG_ESPDOC = :ESPDOC AND   '+
                          '   CPG_CODEMP = :CODEMP AND   '+
                          '   CPG_CODCLI = :CODCLI AND   '+
                          '   CPG_CODCPP = :CODCPP       ';

    qryCppGer.ParamByName('NUMDOC').AsString := strNumDoc;
    qryCppGer.ParamByName('ESPDOC').AsString := strEspDoc;
    qryCppGer.ParamByName('CODEMP').AsString := strCodEmp;
    qryCppGer.ParamByName('CODCLI').AsString := strCodCli;
    qryCppGer.ParamByName('CODCPP').AsString := strCodPro;
    qryCppGer.Open;

    If (qryCppGer.IsEmpty) Then
      Exit;

    Result := qryCppGer.FieldByName('QTDE').AsInteger;
  Finally
    FreeAndNil(qryCppGer);
  End;
end;

procedure TControleCupomPromocao.pImprimeColecaoDeCupons(cdsCupons: TUniClientDataSet);
var
  objCupom: TCupomGerado;
  strDocCup,
  strDocCupAnt,
  strPromo,
  strPromoAnt: String;
  intQtde: Integer;
  blnImprimir: Boolean;
begin
  strDocCupAnt := EmptyStr;
  strDocCup    := EmptyStr;
  strPromo     := EmptyStr;
  strPromoAnt  := EmptyStr;
  intQtde := 0;

  For objCupom In FlstCuponsGerados Do
  Begin
    blnImprimir := True;

    If FImpSintetico Then
    Begin
      strDocCup := objCupom.strNumDoc + '-' + objCupom.strEspDoc + '-' + objCupom.strCodEmp;
      strPromo  := objCupom.strCodCpp + ' - ' + objCupom.strDesCpp;

      If (not cdsCupons.Locate('DOCUMENTO;PROMOCAO', VarArrayOf([strDocCup, strPromo]), [])) Then
        Continue;

      if (strDocCup <> strDocCupAnt) or (strPromo <> strPromoAnt) then
        intQtde := 1;

      if (intQtde > cdsCupons.FieldByName('QUANTIDADE').AsInteger) then
        Continue;

      if (not fEmptyStr(objCupom.strCodLay)) and (not fExisteLayoutLAYETI(objCupom.strCodLay, 0, objCupom.strEmpCpp)) then
      begin
        fMensagem(EmptyStr, 'Layout ' + objCupom.strCodLay + ' não encontrado para essa promoção!', ['&Ok']);
        Break;
      end;

      If (Not fEmptyStr(objCupom.strCodLay)) And (strDocCupAnt = strDocCup) And (strPromoAnt = strPromo) Then
        blnImprimir := False;
    End
    Else
    Begin
      If (Not cdsCupons.Locate('CUPOM', objCupom.strSequen, [])) Then
        Continue;
    End;

    If blnImprimir Then
    Begin
      pImprimeCupom(objCupom, cdsCupons.FieldByName('QUANTIDADE').AsInteger);
      strDocCupAnt := strDocCup;
      strPromoAnt  := strPromo;
      intQtde      := intQtde + 1;
    End;

    pMarcaComoReimpresso(objCupom.Autoincrem, objCupom.strImpres);
    pGravaLog(objCupom);
  End;
end;

procedure TControleCupomPromocao.pImprimeCupom(objCupom: TCupomGerado; AQtde: Integer = 0);
  Var
    frmModeloCupomPromocao: TfrmModeloCupomPromocao;
    objCupPro: TCupomPromocao;
    strCgcCli: String;
    strRGCli : String;
    strTelCli: String;
    strCodVen: String;
    strNomVen: String;
    intContCp: Integer;
begin
  pCriarFormularios(TfrmModeloCupomPromocao, frmModeloCupomPromocao);
  objCupPro := fCupomPromocional(objCupom.strCodCpp);
  Try
    strCgcCli := fRetCgcCpf(objCupom.strCodCli);
    strRGCli  := fRetornaInformacaoDeCliente('CLI_NUMR_G', objCupom.strCodCli);
    strTelCli := fRetornaTelefonesCliente(objCupom.strCodCli);
    strCodVen := fRetornaInformacaoDocumento('CODVEN',
                                             objCupom.strNumDoc,
                                             objCupom.strEspDoc,
                                             objCupom.strCodEmp,
                                             objCupom.strCodCli);
    strNomVen := fRetNomVendRep(strCodVen);

    if (AQtde > 0) then
      intContCp := AQtde
    else
      intContCp := fRetornaQuantidadeDeCupons(objCupom.strNumDoc,
                                              objCupom.strEspDoc,
                                              objCupom.strCodEmp,
                                              objCupom.strCodCli,
                                              objCupom.strCodCpp);

    frmModeloCupomPromocao.pImprimeCupom(objCupom.strCodLay,
                                         objCupom.strCodCli,
                                         objCupom.strNumDoc,
                                         objCupom.strEspDoc,
                                         objCupom.strCodEmp,
                                         fRetNomCliente(objCupom.strCodCli),
                                         strCgcCli,
                                         strRGCli,
                                         strTelCli,
                                         strNomVen,
                                         strLoginUsuarioLogado,
                                         objCupPro.strCupTil,
                                         objCupPro.strCupDes,
                                         intContCp,
                                         objCupom.strCodCpp,
                                         objCupom.strEmpCpp,
                                         IIF(FImpSintetico, EmptyStr, objCupom.strSequen),
                                         IIF(AQtde = 0, objCupom.strSeqPro, ''),
                                         objCupom.strCodigoCupom);
  Finally
    pFreeAndNil(frmModeloCupomPromocao);
    FreeAndNil(objCupPro);
  End;
end;

procedure TControleCupomPromocao.pImprimirCuponsGerados(
  const AFatVenda: TFatVenda; const AblnOriF11: Boolean);
var
  strNumDoc,
  strEspDoc,
  strCodEmp,
  strCondicao    : String;
  objCupomGerado : TCupomGerado;
begin
  If (Not FblnPermiteUtilizarCupomPromocional) Then
    Exit;

  If AblnOriF11 And AFatVenda.fTemNumOrc Then
  Begin
    strNumDoc := AFatVenda.strNumOrc;
    strEspDoc := AFatVenda.strEspOrc;
    strCodEmp := VS_strCodEmp;
  End
  Else
  Begin
    strNumDoc := AFatVenda.strNumDoc;
    strEspDoc := AFatVenda.strEspDoc;
    strCodEmp := VS_strCodEmp;
  End;

  strCondicao := ' WHERE CPG_NUMDOC = "'+ strNumDoc +'" '
               + '   AND CPG_ESPDOC = "'+ strEspDoc +'" '
               + '   AND CPG_CODEMP = "'+ strCodEmp +'" ';

  pCarregaListaCupons(strCondicao);
  For objCupomGerado in FlstCuponsGerados Do
  Begin
    If fImprimeCupomFaturamento(objCupomGerado.strImpCup) Then
    Begin
      pImprimeCupom(objCupomGerado);
      If (fEmptyStr(objCupomGerado.strSeqPro)) Then
        Break;
    End;
  End;
end;

function TControleCupomPromocao.fCupomImpressoNoPedido(const AFatVenda: TFatVenda; AOriF11: Boolean = False): Boolean;
var
  qryCupom: TUniQuery;
begin
  qryCupom := fCriaQuery;

  try
    qryCupom.Close;
    qryCupom.SQL.Clear;
    qryCupom.SQL.Add('SELECT C.AUTOINCREM ');
    qryCupom.SQL.Add('FROM CPPGER C ');
    qryCupom.SQL.Add('INNER JOIN FATGOR F ON (C.CPG_NUMDOC = F.FGO_NUMDOC ');
    qryCupom.SQL.Add('                   AND  C.CPG_ESPDOC = F.FGO_ESPDOC ');
    qryCupom.SQL.Add('                   AND  C.CPG_CODEMP = F.FGO_CODEMP ');
    qryCupom.SQL.Add('                   AND  C.CPG_CODCLI = F.FGO_CODCLI)');
    qryCupom.SQL.Add('WHERE F.FGO_NUMFAT = :NUMDOC ');
    qryCupom.SQL.Add('  AND F.FGO_TIPFAT = :ESPDOC ');
    qryCupom.SQL.Add('  AND F.FGO_EMPFAT = :CODEMP ');

    if fCfgSis('CPPF11', varBoolean) then
    begin
      qryCupom.SQL.Add('UNION ');
      qryCupom.SQL.Add('SELECT C.AUTOINCREM ');
      qryCupom.SQL.Add('FROM CPPGER C ');
      qryCupom.SQL.Add('INNER JOIN FATGOR F ON (C.CPG_NUMDOC = F.FGO_NUMDOC ');
      qryCupom.SQL.Add('                   AND  C.CPG_ESPDOC = F.FGO_ESPDOC ');
      qryCupom.SQL.Add('                   AND  C.CPG_CODEMP = F.FGO_CODEMP ');
      qryCupom.SQL.Add('                   AND  C.CPG_CODCLI = F.FGO_CODCLI)');
      qryCupom.SQL.Add('INNER JOIN FATGOR FAT ON (FAT.FGO_NUMDOC = F.FGO_NUMFAT ');
      qryCupom.SQL.Add('                      AND FAT.FGO_ESPDOC = F.FGO_TIPFAT ');
      qryCupom.SQL.Add('                      AND FAT.FGO_CODEMP = F.FGO_EMPFAT ');
      qryCupom.SQL.Add('                      AND FAT.FGO_CODCLI = F.FGO_CODCLI)');
      qryCupom.SQL.Add('WHERE FAT.FGO_NUMFAT = :NUMDOC ');
      qryCupom.SQL.Add('  AND FAT.FGO_TIPFAT = :ESPDOC ');
      qryCupom.SQL.Add('  AND FAT.FGO_EMPFAT = :CODEMP ');
    end;

    if AOriF11 and AFatVenda.fTemNumOrc then
    begin
      qryCupom.ParamByName('NUMDOC').AsString := AFatVenda.strNumOrc;
      qryCupom.ParamByName('ESPDOC').AsString := AFatVenda.strEspOrc;
      qryCupom.ParamByName('CODEMP').AsString := AFatVenda.strEmpOri;
    end
    else
    begin
      qryCupom.ParamByName('NUMDOC').AsString := AFatVenda.strNumDoc;
      qryCupom.ParamByName('ESPDOC').AsString := AFatVenda.strEspDoc;
      qryCupom.ParamByName('CODEMP').AsString := AFatVenda.strEmpDoc;
    end;

    qryCupom.Open;

    Result := Not qryCupom.IsEmpty;
  finally
    FreeAndNil(qryCupom);
  end;
end;

function TControleCupomPromocao.fCupomPromocional(strCodCpp: String): TCupomPromocao;
  Var
    qryCadCpp: TUniQuery;
    objCupPro: TCupomPromocao;
begin
  qryCadCpp := fCriaQuery;
  objCupPro := TCupomPromocao.Create;

  Try
    pCarregaCupomPromocional(qryCadCpp, strCodCpp);
    pPreencheObjCupomPromocional(objCupPro, qryCadCpp);
    Result := objCupPro;
  Finally
    FreeAndNil(qryCadCpp);
  End;
end;

procedure TControleCupomPromocao.pCarregaCupomPromocional(qryCadCpp: TUniQuery;
  strCodCpp: String);
begin
  qryCadCpp.Close;
  qryCadCpp.SQL.Clear;
  qryCadCpp.SQL.Text := 'SELECT                      '+
                        '  *                         '+
                        'FROM                        '+
                        '  CADCPP                    '+
                        'WHERE                       '+
                        '  CPP_CODCPP = :CODCPP      ';

  qryCadCpp.ParamByName('CODCPP').AsString := strCodCpp;
  qryCadCpp.Open;
end;

procedure TControleCupomPromocao.pPreencheObjCupomPromocional(objCupPro: TCupomPromocao;
  qryCapCpp: TUniQuery);
begin
  objCupPro.strCodPro := qryCapCpp.FieldByName('CPP_CODCPP').AsString;
  objCupPro.intTipPro := qryCapCpp.FieldByName('CPP_TIPPRO').AsInteger;
  objCupPro.fltValPr1 := qryCapCpp.FieldByName('CPP_VLCPP1').AsFloat;
  objCupPro.fltValPr2 := qryCapCpp.FieldByName('CPP_VLCPP2').AsFloat;
  objCupPro.intNumCup := qryCapCpp.FieldByName('CPP_NUMCUP').AsInteger;
  objCupPro.strCupTil := qryCapCpp.FieldByName('CPP_DESCPP').AsString;
  objCupPro.strCupDes := qryCapCpp.FieldByName('CPP_DESCRI').AsString;
  objCupPro.strTipCli := qryCapCpp.FieldByName('CPP_TIPCLI').AsString;
  objCupPro.strCpcLcs := qryCapCpp.FieldByName('CPP_CPCLCS').AsString;
  objCupPro.strAcmVal := qryCapCpp.FieldByName('CPP_ACMVAL').AsString;
  objCupPro.strCodEmp := qryCapCpp.FieldByName('CPP_CODEMP').AsString;
  objCupPro.strImpCup := qryCapCpp.FieldByName('CPP_IMPCUP').AsString;
end;

procedure TControleCupomPromocao.pMarcaComoReimpresso(strAutInc, strImpresso: String);
  Var
    qryCppGer: TUniQuery;
begin
  qryCppGer := fCriaQuery;

  Try
    Try
      fStartTransaction;

      qryCppGer.Close;
      qryCppGer.SQL.Clear;
      qryCppGer.SQL.Text := 'UPDATE                         '+
                            '  CPPGER                       '+
                            'SET                            '+
                            '  CPG_TIPIMP = :CPG_TIPIMP     '+
                            'WHERE                          '+
                            '  AUTOINCREM = :AUTOINCREM     ';

      qryCppGer.ParamByName('CPG_TIPIMP').AsString := IIF(strImpresso = 'N', 'S', 'R');
      qryCppGer.ParamByName('AUTOINCREM').AsString := strAutInc;
      qryCppGer.ExecSQL;

      fCommit;
    Except
      On E: Exception Do
        fRollBack;
    End;
  Finally
    FreeAndNil(qryCppGer);
  End;
end;

procedure TControleCupomPromocao.pGerarCupomPromocional(
  const AFatVenda: TFatVenda; const AArrItens: Array Of TDadosFechamento;
  const AblnOriF11: Boolean);
var
  objCupomPromocao : TCupomPromocao;
  lstCupomPromo    : TObjectList<TCupomPromocao>;
begin
  lstCupomPromo := fItemEmPromocaoCupom(AFatVenda, AArrItens);
  Try
    For objCupomPromocao In lstCupomPromo Do
    Begin
      pCalculaNumeroCupons(objCupomPromocao, AFatVenda, AblnOriF11);
      pCarregarDadosGravacao(AFatVenda, objCupomPromocao, AblnOriF11);

      pGravarControleCupomPromocao;
    End;
  Finally
    FreeAndNil(lstCupomPromo);
  End;
end;

procedure TControleCupomPromocao.pGravaLog(objCupom: TCupomGerado);
  Var
    objLogCpp: TLogCpp;
begin
  objLogCpp := TLogCpp.Create;

  Try
    objLogCpp.pGravar(objCupom.Autoincrem);
  Finally
    FreeAndNil(objLogCpp);
  End;
end;

end.

