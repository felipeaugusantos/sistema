unit untMovMeGerar;

interface

uses untMovMeXML, System.Classes, Uni, System.SysUtils, Data.Db, untMovMeComunica,
     untMovMeTypes, StrUtils, untFuncoes, DateUtils, untModulo,
     untConstantes, Forms, cxProgressBar;

type
  TMovMeGerar = Class(TComponent)
  private
    objCom : TMovMeComunica;
    procedure pExportaGrupoSubGrupo(ArrLinGru: TArrLinGru; blnGrupo: Boolean);
    function fPostItens(ArrIte :TArrIte): Boolean;
    function fPostSchedules(ArrSchedules: TArrSchedules): Boolean;
    function fPostNotasFiscais(ArrNF :TArrNF) :Boolean;
    function fPostScheduleItems(ArrScheduleItems :TArrScheduleItems) :Boolean;
    function fCriarSchedules :TArrSchedules;
    function fCriarScheduleItems(arrItensNF :TArrIteNF) :TArrScheduleItems;
    function fCriarScheduleRoutings :Boolean;
    function fChecaClientes(ArrCli :TArrCli) :Boolean;
    function fChecarConfig :Boolean;
    function fChecaAmarracaoMotorista(arrSchedules :TArrSchedules) :Boolean;
    function fMotoristaBloqueado(strCodMot :String) :Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure pComunicar(pgbStatus: TcxProgressBar = Nil);
  end;

implementation

{ TMovMeGerar }

uses untFuncoesSimples, untGravando, untMensagemExplicativa;

constructor TMovMeGerar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  objCom := TMovMeComunica.Create(Self);
end;

destructor TMovMeGerar.Destroy;
begin
  FreeAndNil(objCom);
  inherited Destroy;
end;

function TMovMeGerar.fCriarSchedules: TArrSchedules;
Var
  qryRomGer : TUniQuery;
  arrSchedules :TArrSchedules;
begin
  qryRomGer := fCriaQuery;

  try
    With qryRomGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT ');
      SQL.Add(' GER_CODCLI, ');
      SQL.Add(' CONCAT(IFNULL(GER_NUMFAT, ""), "-", IFNULL(GER_TIPFAT, ""), "-", IFNULL(GER_EMPFAT, GER_EMPROM)) AS GER_DOCUME, ');
      SQL.Add(' CONCAT(GER_NUMFAT, "-", GER_TIPFAT, "-", GER_CODEMP) AS GER_ROMANE,  ');
      SQL.Add(' GER_DTAROM, ');
      SQL.Add(' GER_HORROM, ');
      SQL.Add(' MOT_CODBAR, ');
      SQL.Add(' MOT_PLAVEI  ');
      SQL.Add('   FROM ROMGERX ');
      SQL.Add('   LEFT JOIN CADMOT ON GER_CODMOT = MOT_CODMOT ');
      SQL.Add(' WHERE GER_JAFATU = 1 ');
      SQL.Add('   AND GER_TIP_FC = "C" ');
      SQL.Add('   AND GER_LIBENT = "S" ');
      SQL.Add('   AND GER_DTABAI IS NULL ');
      SQL.Add('   AND GER_ENTSAI = "S" ');
      SQL.Add('   AND GER_ENVENT = "N" ');
      SQL.Add(' ORDER BY GER_DTAROM ');
      Open;

      SetLength(arrSchedules, RecordCount);

      while not Eof do
      begin
        FillChar(arrSchedules[RecNo-1],  SizeOf(arrSchedules[RecNo-1]),  #0);

        arrSchedules[RecNo-1].blnActive := True;
        arrSchedules[RecNo-1].strActivitiesOrigin := '3';
        arrSchedules[RecNo-1].strAgent := FieldByName('MOT_CODBAR').AsString; {MOT_CODMOT}
        arrSchedules[RecNo-1].strServiceLocal := FieldByName('GER_CODCLI').AsString; {GER_CODCLI}
        arrSchedules[RecNo-1].strAlternativeIdentifier := FieldByName('GER_ROMANE').AsString; {000000210706-NF-001}

        IF StrToDate(FormatDateTime('dd/mm/yyyy', FieldByName('GER_DTAROM').AsDateTime)) < Date Then
          arrSchedules[RecNo-1].strDate := FormatDateTime('yyyy-mm-dd', Date) {DATA ROM.}
        ELSE
          arrSchedules[RecNo-1].strDate := FormatDateTime('yyyy-mm-dd', FieldByName('GER_DTAROM').AsDateTime); {DATA ROM.}

        arrSchedules[RecNo-1].strHour := FormatDateTime('hh:mm', FieldByName('GER_HORROM').AsDateTime); {HORA ROM.}

        arrSchedules[RecNo-1].strNF := FieldByName('GER_ROMANE').AsString;
        arrSchedules[RecNo-1].strPlaVei := FieldByName('MOT_PLAVEI').AsString;

        Next;
      end;

      FreeAndNil(qryRomGer);
    End;
  except
    arrSchedules := nil;
  end;

  Result := arrSchedules;
end;

function TMovMeGerar.fMotoristaBloqueado(strCodMot: String): Boolean;
var
  qryRomaneiosMot :TUniQuery;
begin
  qryRomaneiosMot := fCriaQuery;

  with qryRomaneiosMot do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT GER_CODMOT FROM ROMGERX  ');
    SQL.Add(' WHERE GER_DTABAI IS NULL AND GER_LIBENT = "S" AND GER_ENVENT = "S"');
    SQL.Add(' AND GER_CODMOT = :CODMOT ');

    ParamByName('CODMOT').AsString := strCodMot;

    Open;

    Result := (RecordCount > 0);
  end;
end;

function TMovMeGerar.fChecaAmarracaoMotorista(arrSchedules :TArrSchedules): Boolean;
var
  i :Integer;
  strErros :String;
begin
  strErros := '';

  for i := Low(arrSchedules) to High(arrSchedules) Do
  begin
    Application.ProcessMessages;

    If Trim(arrSchedules[i].strAgent).IsEmpty Then
      strErros := strErros +sLineBreak
                  +arrSchedules[i].strAlternativeIdentifier;
  end;

  If not strErros.IsEmpty Then
  begin
    Try
      pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
      frmMensagemExplicativa.Caption := 'Atenção!';
      frmMensagemExplicativa.mmoInstru.Font.Size := 12;
      frmMensagemExplicativa.mmoInstru.Font.Style := [];
      frmMensagemExplicativa.mmoInstru.Lines.Add('Os motoristas dos seguintes romaneios não possuem vínculo no site uMovMe.');
      frmMensagemExplicativa.mmoInstru.Lines.Add('Verifique o cadastro no site e tente novamente');
      frmMensagemExplicativa.mmoInstru.Lines.Add(strErros);
      frmMensagemExplicativa.mmoInstru.Alignment := taCenter;
      frmMensagemExplicativa.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(e.Message, '[TfrmRomaneioBusca.btnHlpLinClick]')
    End;

    pFreeAndNil(frmMensagemExplicativa);
  end;

  Result := strErros.IsEmpty;
end;

function TMovMeGerar.fChecaClientes(ArrCli: TArrCli): Boolean;
var
  i :Integer;
  strErros :String;
  ArrCliUnico :TArrCli;
  blnGeoOK :Boolean;
begin
  try
    strErros := '';
    // https://api.umov.me/CenterWeb/api/17898e25fe0a17b215f5744d166f2d7932ac03/serviceLocal.xml?alternativeIdentifier=33680

    for i := Low(ArrCli) to High(ArrCli) Do
    begin
      Application.ProcessMessages;

      SetLength(ArrCliUnico, 1);
      ArrCliUnico[0] := ArrCli[i];

      if objCom.fPostCliente(fXmlCliente(ArrCliUnico, 0)) And
         objCom.fChecarCliente(ArrCliUnico[0].strCodCli)
      Then
        blnGeoOK := True

      else if objCom.fPostCliente(fXmlCliente(ArrCliUnico, 1)) And
         objCom.fChecarCliente(ArrCliUnico[0].strCodCli)
      Then
        blnGeoOK := True

      else
      begin
        Application.ProcessMessages;

        objCom.fPostCliente(fXmlCliente(ArrCliUnico, 2));

        blnGeoOK := objCom.fChecarCliente(ArrCliUnico[0].strCodCli);
      end;

      If not blnGeoOK then
      begin
        If not ArrCli[i].strNomFan.IsEmpty Then
        Begin
          strErros := strErros +sLineBreak
                      +ArrCli[i].strCodCli +' - ' +ArrCli[i].strNomFan
                      +'(' +ArrCli[i].strEndere +')';
        End

        Else
        Begin
          strErros := strErros +sLineBreak
                      +ArrCli[i].strCodCli +' - ' +ArrCli[i].strRazSoc
                      +'(' +ArrCli[i].strEndere +')';
        End;
      End;
    end;

    If not strErros.IsEmpty Then
    begin
        Try
          pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
          frmMensagemExplicativa.Caption := 'Atenção!';
          frmMensagemExplicativa.mmoInstru.Font.Size := 12;
          frmMensagemExplicativa.mmoInstru.Font.Style := [];
          frmMensagemExplicativa.mmoInstru.Lines.Add('O endereço dos seguintes clientes não foi localizado pela uMovMe.');
          frmMensagemExplicativa.mmoInstru.Lines.Add('Verifique o endereço ou tente novamente mais tarde');
          frmMensagemExplicativa.mmoInstru.Lines.Add(strErros);
          frmMensagemExplicativa.mmoInstru.Alignment := taCenter;
          frmMensagemExplicativa.ShowModal;
        Except
          On E: Exception Do
            pMensagensErro(e.Message, '[TfrmRomaneioBusca.btnHlpLinClick]')
        End;

        pFreeAndNil(frmMensagemExplicativa);
    end;

    Result := strErros.IsEmpty;
  except
    on E: Exception do
    begin

      Try
        pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
        frmMensagemExplicativa.Caption := 'Atenção!';
        frmMensagemExplicativa.mmoInstru.Font.Size := 12;
        frmMensagemExplicativa.mmoInstru.Font.Style := [];
        frmMensagemExplicativa.mmoInstru.Lines.Add(E.Message);
        frmMensagemExplicativa.mmoInstru.Alignment := taCenter;
        frmMensagemExplicativa.ShowModal;
      Except
        On E: Exception Do
          pMensagensErro(e.Message, '[TfrmRomaneioBusca.btnHlpLinClick]')
      End;

      pFreeAndNil(frmMensagemExplicativa);

      Result := False;
    end;
  end;
end;

function TMovMeGerar.fChecarConfig: Boolean;
var
  strErros :String;
begin
  strErros := '';

  If fCfgSis('URLMOV', varString) = '' Then
    strErros := strErros +sLineBreak
                +'- Config. URLMOV não preenchida';

  If fCfgSis('TOKMOV', varString) = '' Then
    strErros := strErros +sLineBreak
                +'- Config. TOKMOV não preenchida';

  If fCfgSis('IDNFMV', varString) = '' Then
    strErros := strErros +sLineBreak
                +'- Config. IDNFMV não preenchida';

  If fCfgSis('GEOORI', varString) = '' Then
    strErros := strErros +sLineBreak
                +'- Config. GEOORI não preenchida';

  If not strErros.IsEmpty Then
  begin
        Try
          pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
          frmMensagemExplicativa.Caption := 'Atenção!';
          frmMensagemExplicativa.mmoInstru.Font.Size := 12;
          frmMensagemExplicativa.mmoInstru.Font.Style := [];
          frmMensagemExplicativa.mmoInstru.Lines.Add('Erros nas configurações:');
          frmMensagemExplicativa.mmoInstru.Lines.Add(strErros);
          frmMensagemExplicativa.mmoInstru.Alignment := taCenter;
          frmMensagemExplicativa.ShowModal;
        Except
          On E: Exception Do
            pMensagensErro(e.Message, '[TfrmRomaneioBusca.btnHlpLinClick]')
        End;

        pFreeAndNil(frmMensagemExplicativa);
  end;

  Result := strErros.IsEmpty;
end;

function TMovMeGerar.fCriarScheduleItems(arrItensNF :TArrIteNF): TArrScheduleItems;
Var
  intCnt : Integer;
  arrScheduleItems: TArrScheduleItems;
begin
  SetLength(arrScheduleItems, Length(arrItensNF));

  For intCnt := Low(arrItensNF) To High(arrItensNF) Do
  Begin
    arrScheduleItems[intCnt].strItemId := arrItensNF[intCnt].strCodIte;
    arrScheduleItems[intCnt].strScheduleAltId := arrItensNF[intCnt].strNumRom;
    arrScheduleItems[intCnt].strCustomQtdProd := fFloatToStrPonto(arrItensNF[intCnt].fltQtdIte, 12, fCfgSis('DECQTD', varInteger));
    arrScheduleItems[intCnt].strCustomNroNF := arrItensNF[intCnt].strNumDoc;
  End;

  Result := arrScheduleItems;
end;

function TMovMeGerar.fCriarScheduleRoutings: Boolean;
var
  arrScheduleRoutings :TArrScheduleRoutings;
  qryMotoristas : TUniQuery;
  qryRotas : TUniQuery;
  strMotoristasBloqueados :String;
begin
  strMotoristasBloqueados := '';

  qryMotoristas := fCriaQuery;
  qryRotas := fCriaQuery;

  try
    With qryMotoristas Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT GER_CODMOT, MOT_CODBAR, MOT_NOMMOT ');
      SQL.Add('   FROM ROMGERX ');
      SQL.Add('   LEFT JOIN CADMOT ON GER_CODMOT = MOT_CODMOT ');
      SQL.Add(' WHERE GER_JAFATU = 1 ');
      SQL.Add('   AND GER_TIP_FC = "C" ');
      SQL.Add('   AND GER_LIBENT = "S" ');
      SQL.Add('   AND GER_DTABAI IS NULL ');
      SQL.Add('   AND GER_ENTSAI = "S" ');
      SQL.Add('   AND GER_ENVENT = "N" ');
      SQL.Add(' GROUP BY MOT_CODBAR ');
      SQL.Add(' ORDER BY GER_CODMOT ');
      Open;

      While Not Eof Do
      Begin
        if not fMotoristaBloqueado(FieldByName('GER_CODMOT').AsString) then
        begin
          qryRotas.Close;
          qryRotas.SQL.Clear;
          qryRotas.SQL.Add(' SELECT CONCAT(GER_NUMFAT, "-", GER_TIPFAT, "-", GER_CODEMP) AS DOC ');
          qryRotas.SQL.Add('   FROM ROMGERX ');
          qryRotas.SQL.Add(' WHERE GER_JAFATU = 1 ');
          qryRotas.SQL.Add('   AND GER_TIP_FC = "C" ');
          qryRotas.SQL.Add('   AND GER_LIBENT = "S" ');
          qryRotas.SQL.Add('   AND GER_DTABAI IS NULL ');
          qryRotas.SQL.Add('   AND GER_ENTSAI = "S" ');
          qryRotas.SQL.Add('   AND GER_ENVENT = "N" ');
          qryRotas.SQL.Add('   AND GER_CODMOT = :CODMOT ');
          qryRotas.SQL.Add(' ORDER BY DOC ');

          qryRotas.ParamByName('CODMOT').AsString := FieldByName('GER_CODMOT').AsString;

          qryRotas.Open;

          SetLength(arrScheduleRoutings, Length(arrScheduleRoutings)+1);

          arrScheduleRoutings[RecNo-1].agentId := FieldByName('MOT_CODBAR').AsString;

          SetLength(arrScheduleRoutings[RecNo-1].arrScheduleIds, qryRotas.RecordCount);

          While Not qryRotas.Eof Do
          Begin
            Application.ProcessMessages;

            arrScheduleRoutings[RecNo-1].arrScheduleIds[qryRotas.RecNo-1] :=
              objCom.fGetScheduleIds(qryRotas.FieldByName('DOC').AsString);

            qryRotas.Next;
          End;

          Next;
        end
        else
        begin
          strMotoristasBloqueados := strMotoristasBloqueados +sLineBreak
                                    +FieldByName('GER_CODMOT').AsString +' - ' +FieldByName('MOT_NOMMOT').AsString;

          Next;
        end;
      End;

      FreeAndNil(qryMotoristas);
      FreeAndNil(qryRotas);
    End;
  except
    arrScheduleRoutings := nil;
  end;

  if not strMotoristasBloqueados.IsEmpty then
  begin

     Try
       pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
       frmMensagemExplicativa.Caption := 'Atenção!';
       frmMensagemExplicativa.mmoInstru.Font.Size := 12;
       frmMensagemExplicativa.mmoInstru.Font.Style := [];
       frmMensagemExplicativa.mmoInstru.Lines.Add('Os motoristas a seguir possuem entregas em curso');
       frmMensagemExplicativa.mmoInstru.Lines.Add('Aguarde o retorno do motorista e tente novamente');
       frmMensagemExplicativa.mmoInstru.Lines.Add(strMotoristasBloqueados);
       frmMensagemExplicativa.mmoInstru.Alignment := taCenter;
       frmMensagemExplicativa.ShowModal;
     Except
       On E: Exception Do
         pMensagensErro(e.Message, '[TfrmRomaneioBusca.btnHlpLinClick]')
     End;

     pFreeAndNil(frmMensagemExplicativa);

    if Length(arrScheduleRoutings) = 0 then
      arrScheduleRoutings := nil;
  end;

  if arrScheduleRoutings = nil then
    Result := False
  else
    Result := objCom.fPostScheduleRoutings(arrScheduleRoutings);
end;

function TMovMeGerar.fPostItens(ArrIte: TArrIte): Boolean;
Var
  intCnt :Integer;
  ArrIteTmp: TArrIte;
begin
  Result := True;

  For intCnt := Low(ArrIte) To High(ArrIte) Do
  begin
    Application.ProcessMessages;

    SetLength(ArrIteTmp, Length(ArrIteTmp) + 1);

    ArrIteTmp[Length(ArrIteTmp)-1] := ArrIte[intCnt];

    If (Length(ArrIteTmp) = 50) Or
       (intCnt = High(ArrIte)) Then
    Begin
      Result := objCom.fPostItens(fXMLItens(ArrIteTmp));
      SetLength(ArrIteTmp, 0);
    End;
  end;
End;

function TMovMeGerar.fPostNotasFiscais(ArrNF: TArrNF): Boolean;
Var
  intCnt :Integer;
  ArrNFTmp: TArrNF;
begin
  Result := True;

  For intCnt := Low(ArrNF) To High(ArrNF) Do
  begin
    Application.ProcessMessages;
    SetLength(ArrNFTmp, Length(ArrNFTmp) + 1);

    ArrNFTmp[Length(ArrNFTmp)-1] := ArrNF[intCnt];

    If (Length(ArrNFTmp) = 50) Or
       (intCnt = High(ArrNF)) Then
    Begin
      Result := objCom.fPostNotasFiscais(fXMLNotasFiscais(ArrNFTmp));
      SetLength(ArrNFTmp, 0);
    End;
  end;
end;

function TMovMeGerar.fPostScheduleItems(
  ArrScheduleItems: TArrScheduleItems): Boolean;
Var
  intCnt :Integer;
  ArrScheduleItemsTmp: TArrScheduleItems;
begin
  Result := True;

  For intCnt := Low(ArrScheduleItems) To High(ArrScheduleItems) Do
  begin
    Application.ProcessMessages;
    SetLength(ArrScheduleItemsTmp, Length(ArrScheduleItemsTmp) + 1);

    ArrScheduleItemsTmp[Length(ArrScheduleItemsTmp)-1] := ArrScheduleItems[intCnt];

    If (Length(ArrScheduleItemsTmp) = 50) Or
       (intCnt = High(ArrScheduleItems)) Then
    Begin
      Result := objCom.fPostScheduleItems(fXMLScheduleItems(arrScheduleItemsTmp));
      SetLength(ArrScheduleItemsTmp, 0);
    End;
  end;
end;

function TMovMeGerar.fPostSchedules(ArrSchedules: TArrSchedules): Boolean;
Var
  intCnt :Integer;
  ArrScheduleTmp: TArrSchedules;
begin
  Result := True;

  For intCnt := Low(ArrSchedules) To High(ArrSchedules) Do
  begin
    Application.ProcessMessages;
    SetLength(ArrScheduleTmp, Length(ArrScheduleTmp) + 1);

    ArrScheduleTmp[Length(ArrScheduleTmp)-1] := ArrSchedules[intCnt];

    If (Length(ArrScheduleTmp) = 50) Or
       (intCnt = High(ArrSchedules)) Then
    Begin
      Result := objCom.fPostSchedules(fXMLSchedules(ArrScheduleTmp));
      SetLength(ArrScheduleTmp, 0);
    End;
  end;
End;

//function TMovMeGerar.fPostItensNota(ArrIteNF: TArrIteNF): Boolean;
//Var
//  intCnt : Integer;
//begin
//  For intCnt := Low(ArrIteNF) To High(ArrIteNF) Do
//    If Not objCom.fPostItemNotasFiscais(fXMLItemNotasFiscais(ArrIteNF[intCnt])) Then
//      objCom.fAtualizaItemNotasFiscais(fXMLItemNotasFiscais(ArrIteNF[intCnt]), ArrIteNF[intCnt].strDescription);
//  Result := True;
//end;

procedure TMovMeGerar.pComunicar(pgbStatus: TcxProgressBar = Nil);
Var
  qryRomGer : TUniQuery;
  qryRomDet : TUniQuery;
  qryUpdate : TUniQuery;
  qryClean : TUniQuery;
  ArrCli : TArrCli;
  ArrNF : TArrNF;
  ArrIteNF : TArrIteNF;
  ArrIte   : TArrIte;
  stlClientes : TStringList;
  stlItens : TStringList;
  stlGrupo : TStringList;
  stlSubGrupo : TStringList;
  ArrGrupos : TArrLinGru;
  ArrSubGrupos : TArrLinGru;
  arrSchedules :TArrSchedules;
  arrScheduleItems :TArrScheduleItems;
begin
  If not fChecarConfig Then
    raise Exception.Create('Corrija as configurações e tente novamente');

  pInformacao('Organizando lista de dados para envio...', pgbStatus);

  qryRomGer := fCriaQuery;
  qryRomDet := fCriaQuery;
  qryUpdate := fCriaQuery;
  qryClean := fCriaQuery;
  stlClientes := TStringList.Create;
  stlItens := TStringList.Create;
  stlGrupo := TStringList.Create;
  stlSubGrupo := TStringList.Create;
  Try
    With qryUpdate Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE ROMGERX ');
      SQL.Add('    SET GER_ENVENT = "S" ');
      SQL.Add('  WHERE AUTOINCREM = :AUTINC ');
    End;

    With qryClean Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE ROMGERX ');
      SQL.Add('    SET GER_LIBENT = "N" ');
      SQL.Add('  WHERE AUTOINCREM = :AUTINC ');
    End;

    With qryRomDet Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('  SELECT DET_CODITE, DET_QTDITE, ITE_CODBAR, I.ITE_DESITE, ');
      SQL.Add('         G.ITE_PREVE1, UNI_DESUNI, ITE_ITEATI, ITE_CODGRU, GRU_DESGRU, ');
      SQL.Add('         ROMDETX.AUTOINCREM AS DETINC ');
      SQL.Add('    FROM ROMDETX ');
      SQL.Add('    LEFT JOIN CADITE I ON I.ITE_CODITE = DET_CODITE  ');
      SQL.Add('    LEFT JOIN ITEGER G ON G.ITE_CODITE = DET_CODITE  ');
      SQL.Add('                 AND G.ITE_CODEMP = DET_CODEMP  ');
      SQL.Add('    LEFT JOIN CADGRU ON GRU_CODGRU = ITE_CODGRU ');
      SQL.Add('    LEFT JOIN CADUNI ON UNI_CODUNI = DET_UNIDAD ');
      SQL.Add('   WHERE DET_SEQGER = :SEQGER ');
    End;

    With qryRomGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT GER_CODCLI, ');
      SQL.Add('        CLI_FANSOB, ');
      SQL.Add('        CLI_NOMCLI, ');
      SQL.Add('        CIDCLI.CID_ESTADO, ');
      SQL.Add('        CLI_ENDERE, ');
      SQL.Add('        CLI_ENDNUM, ');
      SQL.Add('        CLI_BAIRRO, ');
      SQL.Add('        CLI_ENDCOM, ');
      SQL.Add('        CLI_EMAIL_, ');
      SQL.Add('        CLI_C_G_C_, ');
      SQL.Add('        CLI_C_E_P_, ');
      SQL.Add('        CLI_FONE01, ');
      SQL.Add('        CLI_CELULA, ');
      SQL.Add('        CIDCLI.CID_NOMCID, ');
      SQL.Add('        CONCAT(IFNULL(GER_NUMFAT, ""), "-", IFNULL(GER_TIPFAT, ""), "-", IFNULL(GER_EMPFAT, GER_EMPROM)) AS GER_DOCUME,  ');
      SQL.Add('        CONCAT(GER_NUMFAT, "-", GER_TIPFAT, "-", GER_CODEMP) AS GER_ROMANE,  ');
      SQL.Add('        GER_DTAFAT, ');

      SQL.Add('        IF(CIDENT.CID_CODCID IS NULL, CIDCLI.CID_ESTADO, CIDENT.CID_ESTADO) AS ENT_ESTADO, ');
      SQL.Add('        IF(CIDENT.CID_CODCID IS NULL, CLI_ENDERE,        ETC_ENDENT)        AS ENT_ENDERE, ');
      SQL.Add('        IF(CIDENT.CID_CODCID IS NULL, CLI_BAIRRO,        ETC_BAIENT)        AS ENT_BAIRRO, ');
      SQL.Add('        IF(CIDENT.CID_CODCID IS NULL, CLI_ENDCOM,        "")                AS ENT_ENDCOM, ');
      SQL.Add('        IF(CIDENT.CID_CODCID IS NULL, CLI_C_E_P_,        ETC_CEPENT)        AS ENT_C_E_P_, ');
      SQL.Add('        IF(CIDENT.CID_CODCID IS NULL, CIDCLI.CID_NOMCID, CIDENT.CID_NOMCID) AS ENT_NOMCID, ');

      SQL.Add('        ROMGERX.AUTOINCREM ');
      SQL.Add('   FROM ROMGERX ');
      SQL.Add('   JOIN CADCLI ON CLI_CODCLI = GER_CODCLI ');
      SQL.Add('   JOIN CADCID CIDCLI ON CIDCLI.CID_CODCID = CLI_CODCID ');
      SQL.Add('   LEFT JOIN ENTCLI ON ENTCLI.AUTOINCREM = GER_ENTGER ');
      SQL.Add('   LEFT JOIN CADCID CIDENT ON ENTCLI.ETC_CIDENT = CIDENT.CID_CODCID ');
      SQL.Add('  WHERE GER_JAFATU = 1 ');
      SQL.Add('    AND GER_TIP_FC = "C" ');
      SQL.Add('    AND GER_LIBENT = "S" ');
      SQL.Add('    AND GER_DTABAI IS NULL ');
      SQL.Add('    AND GER_ENTSAI = "S" ');
      SQL.Add('    AND GER_ENVENT = "N" ');
      SQL.Add('  ORDER BY GER_DTAFAT ');
      Open;

      If (Not IsEmpty) Then
      Begin
        SetLength(ArrNF,  RecordCount);

        First;
        While Not Eof Do
        Begin
          FillChar(ArrNF[RecNo-1],  SizeOf(ArrNF[RecNo-1]),  #0);

          If (stlClientes.IndexOf(FieldByName('GER_CODCLI').AsString) < 0) Then
          Begin
            stlClientes.Add(FieldByName('GER_CODCLI').AsString);
            SetLength(ArrCli, Length(ArrCli) + 1);
            ArrCli[Length(ArrCli)-1].strCodCli := FieldByName('GER_CODCLI').AsString;
            ArrCli[Length(ArrCli)-1].strNomFan := FieldByName('CLI_FANSOB').AsString;
            ArrCli[Length(ArrCli)-1].strRazSoc := FieldByName('CLI_NOMCLI').AsString;
            ArrCli[Length(ArrCli)-1].strEndere := FieldByName('ENT_ENDERE').AsString;
            ArrCli[Length(ArrCli)-1].strBairro := FieldByName('ENT_BAIRRO').AsString;
            ArrCli[Length(ArrCli)-1].strNomCid := FieldByName('ENT_NOMCID').AsString;
            ArrCli[Length(ArrCli)-1].strC_e_p_ := FieldByName('ENT_C_E_P_').AsString;
            ArrCli[Length(ArrCli)-1].strNomEst := fRetUFCliente(FieldByName('GER_CODCLI').AsString);
            ArrCli[Length(ArrCli)-1].strComple := FieldByName('CLI_ENDCOM').AsString;
            ArrCli[Length(ArrCli)-1].strE_mail := FieldByName('CLI_EMAIL_').AsString;
            ArrCli[Length(ArrCli)-1].strCpfCnp := FieldByName('CLI_C_G_C_').AsString;
            ArrCli[Length(ArrCli)-1].strFone01 := FieldByName('CLI_FONE01').AsString;
            ArrCli[Length(ArrCli)-1].strCelula := FieldByName('CLI_CELULA').AsString;
          End;

          ArrNF[RecNo-1].strNumDoc := FieldByName('GER_DOCUME').AsString;
          ArrNF[RecNo-1].strNumRom := FieldByName('GER_ROMANE').AsString;
          ArrNF[RecNo-1].strCodCli := FieldByName('GER_CODCLI').AsString;
          ArrNF[RecNo-1].strPaisNF := 'Brasil';
          ArrNF[RecNo-1].strEstado := fRetNomeEstado( FieldByName('ENT_ESTADO').AsString );
          ArrNF[RecNo-1].strCidade := FieldByName('ENT_NOMCID').AsString;
          ArrNF[RecNo-1].strBairNF := FieldByName('ENT_BAIRRO').AsString;
          ArrNF[RecNo-1].strTipEnd := '';
          ArrNF[RecNo-1].strEndere := FieldByName('ENT_ENDERE').AsString;
          ArrNF[RecNo-1].strNumEnd := '';
          ArrNF[RecNo-1].strComple := FieldByName('ENT_ENDCOM').AsString;
          ArrNF[RecNo-1].strC_e_p_ := FieldByName('ENT_C_E_P_').AsString;
          //ArrNF[RecNo-1].dtaDtEntr := 0;
          ArrNF[RecNo-1].dtaDtaEmi := FieldByName('GER_DTAFAT').AsDateTime;

          qryRomDet.Close;
          qryRomDet.ParamByName('SEQGER').AsString := FieldByName('AUTOINCREM').AsString;
          qryRomDet.Open;

          If (Not qryRomDet.IsEmpty) Then
          Begin
            qryRomDet.First;
            While Not qryRomDet.Eof Do
            Begin

              If (stlItens.IndexOf(qryRomDet.FieldByName('DET_CODITE').AsString) < 0) Then
              Begin
                stlItens.Add(qryRomDet.FieldByName('DET_CODITE').AsString);
                SetLength(ArrIte, Length(ArrIte) + 1);
                ArrIte[Length(ArrIte)-1].strCodIte := qryRomDet.FieldByName('DET_CODITE').AsString;
                ArrIte[Length(ArrIte)-1].strDesIte := qryRomDet.FieldByName('ITE_DESITE').AsString;
                ArrIte[Length(ArrIte)-1].strCodEan := qryRomDet.FieldByName('ITE_CODBAR').AsString;
                ArrIte[Length(ArrIte)-1].strUnidad := qryRomDet.FieldByName('UNI_DESUNI').AsString;
                ArrIte[Length(ArrIte)-1].blnIteAti := (qryRomDet.FieldByName('ITE_ITEATI').AsString = 'S');
                ArrIte[Length(ArrIte)-1].fltUnitar := qryRomDet.FieldByName('ITE_PREVE1').AsFloat;
                ArrIte[Length(ArrIte)-1].strLinGru := qryRomDet.FieldByName('ITE_CODGRU').AsString;
              End;

              If (stlGrupo.IndexOf(LeftStr(qryRomDet.FieldByName('ITE_CODGRU').AsString, 3) + '000') < 0) Then
              Begin
                SetLength(ArrGrupos, Length(ArrGrupos) + 1);
                ArrGrupos[Length(ArrGrupos)-1].strCodigo := LeftStr(qryRomDet.FieldByName('ITE_CODGRU').AsString, 3) + '000';
                ArrGrupos[Length(ArrGrupos)-1].strDescri := ArrGrupos[Length(ArrGrupos)-1].strCodigo + ' - ' + fRetNomeLinhaGrupo(ArrGrupos[Length(ArrGrupos)-1].strCodigo);
              End;

              If (stlSubGrupo.IndexOf(qryRomDet.FieldByName('ITE_CODGRU').AsString) < 0) Then
              Begin
                SetLength(ArrSubGrupos, Length(ArrSubGrupos) + 1);
                ArrSubGrupos[Length(ArrSubGrupos)-1].strCodigo := qryRomDet.FieldByName('ITE_CODGRU').AsString;
                ArrSubGrupos[Length(ArrSubGrupos)-1].strDescri := ArrSubGrupos[Length(ArrSubGrupos)-1].strCodigo + ' - ' + qryRomDet.FieldByName('GRU_DESGRU').AsString;
              End;

              SetLength(ArrIteNF, Length(ArrIteNF) + 1);
              ArrIteNF[Length(ArrIteNF)-1].strNumDoc := FieldByName('GER_DOCUME').AsString;
              ArrIteNF[Length(ArrIteNF)-1].strNumRom := FieldByName('GER_ROMANE').AsString;
              ArrIteNF[Length(ArrIteNF)-1].strCodIte := qryRomDet.FieldByName('DET_CODITE').AsString;
              ArrIteNF[Length(ArrIteNF)-1].fltQtdIte := qryRomDet.FieldByName('DET_QTDITE').AsFloat;
              ArrIteNF[Length(ArrIteNF)-1].strDescription := qryRomDet.FieldByName('DETINC').AsString;

              qryRomDet.Next;
            End;
          End;

          Next;
        End;

        pInformacao('Enviando dados de clientes...', pgbStatus);

        If not fChecaClientes(ArrCli) then
        Begin
          raise Exception.Create('Corrija os endereços e tente novamente');
        End;

        pInformacao('Criando tarefas...', pgbStatus);
        arrSchedules := fCriarSchedules;

        pInformacao('Validando dados do motorista no aplicativo...', pgbStatus);
        If not fChecaAmarracaoMotorista(arrSchedules) then
        Begin
          raise Exception.Create('Corrija os dados dos motoristas e tente novamente');
        End;

        arrScheduleItems := fCriarScheduleItems(ArrIteNF);

        pInformacao('Enviando grupos e subgrupos...', pgbStatus);
        pExportaGrupoSubGrupo(ArrGrupos, True);
        pExportaGrupoSubGrupo(ArrSubGrupos, False);

        pInformacao('Enviando dados...', pgbStatus);
        If (fPostItens(ArrIte)) And
           (fPostNotasFiscais(ArrNF)) And
           //(fPostItensNota(ArrIteNF)) And
           (fPostSchedules(arrSchedules)) And
           (fPostScheduleItems(arrScheduleItems)) And
           (fCriarScheduleRoutings) Then
        Begin

          fStartTransaction;

          Try
            qryRomGer.First;
            While Not qryRomGer.Eof Do
            Begin
              qryUpdate.ParamByName('AUTINC').AsString := qryRomGer.FieldByName('AUTOINCREM').AsString;
              qryUpdate.ExecSQL;
              qryRomGer.Next;
            End;

            fCommit;

            fMensagem('Sucesso!', 'Os dados do romaneio foram enviados corretamente à API uMovMe!', ['&Ok']);

          Except
            On E: Exception Do
            Begin
              fRollBack;
            End;
          End;
        End
        Else
        Begin
          fStartTransaction;

          Try
            qryRomGer.First;
            While Not qryRomGer.Eof Do
            Begin
              qryClean.ParamByName('AUTINC').AsString := qryRomGer.FieldByName('AUTOINCREM').AsString;
              qryClean.ExecSQL;
              qryRomGer.Next;
            End;

            fCommit;
          Except
            On E: Exception Do
            Begin
              fRollBack;
            End;
          End;

          fMensagem('ATENÇÃO!', 'Ocorreu um erro no servidor ao enviar os romaneios! Tente Novamente!', ['&Ok']);
        End;
      End;
    End;
  Finally
    FreeAndNil(qryRomDet);
    FreeAndNil(qryRomGer);
    FreeAndNil(stlClientes);
    FreeAndNil(stlItens);
    FreeAndNil(stlGrupo);
    FreeAndNil(stlSubGrupo);
    FreeAndNil(qryUpdate);
  End;
end;

procedure TMovMeGerar.pExportaGrupoSubGrupo(ArrLinGru: TArrLinGru; blnGrupo: Boolean);
  Var
    intCnt : Integer;
begin
  For intCnt := Low(ArrLinGru) To High(ArrLinGru) Do
  Begin
    Application.ProcessMessages;

    If (blnGrupo) Then
    Begin
      If Not objCom.fInsereGrupos(fXMLGrupo(ArrLinGru[intCnt])) Then
        objCom.fAtualizaGrupos(fXMLAtualizaGrupo(ArrLinGru[intCnt]), ArrLinGru[intCnt].strCodigo);
    End
    Else
    Begin
      If Not objCom.fInsereSubGrupos(fXMLSubGrupo(ArrLinGru[intCnt])) Then
        objCom.fAtualizaSubGrupos(fAtualizaSubGrupo(ArrLinGru[intCnt]), ArrLinGru[intCnt].strCodigo);
    End;
  End;
end;

end.
