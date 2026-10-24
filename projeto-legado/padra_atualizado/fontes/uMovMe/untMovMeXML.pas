unit untMovMeXML;

interface

uses System.Variants, System.Classes, XMLDoc, XMLIntf, Forms, untMovMeTypes,
     System.NetEncoding, IdHTTP, IdURI,
     System.SysUtils, StrUtils, untFuncoesSimples, untFuncoes,
     Vcl.StdCtrls, untFuncoesGenerica;

function fXmlCliente(ArrCli: TArrCli; intTentativa :Integer = 0): String;
function fXMLNotasFiscais(arrNF: TarrNF): String;
function fXMLItensNotasFiscais(arrIteNF: TArrIteNF): String;
function fXMLItemNotasFiscais(recIteNF: TrecIteNF): String;
function fXMLItens(arrIte: TarrIte): String;
function fXMLSchedules(arrSchedules: TarrSchedules): String;
function fXMLScheduleItems(arrScheduleItems: TArrScheduleItems): String;
function fXMLScheduleRouting(recScheduleRouting :TrecScheduleRouting): String;
function fXMLGrupo(recLinGru: TrecLinGru): String;
function fXMLAtualizaGrupo(recLinGru: TrecLinGru): String;
function fXMLSubGrupo(recLinGru: TrecLinGru): String;
function fAtualizaSubGrupo(recLinGru: TrecLinGru): String;
function fGetDataString(xml: TXMLDocument): String;
procedure pSaveXML(xml: TXMLDocument);
function fBuscarXML(strXML, strTag :String) :String;

Var
  blnLogar : Boolean;

implementation


function fXmlCliente(ArrCli: TArrCli; intTentativa :Integer = 0): String;
Var
  xml: TXMLDocument;
  serviceLocals: IXMLNode;
  serviceLocal: IXMLNode;
  customFields: IXMLNode;
  intCnt,
  intTst : Integer;
  strEndereco,
  strNumero :String;
begin
  xml := TXMLDocument.Create(Nil);
  Try
    xml.Active := True;

    serviceLocals := xml.AddChild('serviceLocals');

    For intCnt := Low(ArrCli) To High(ArrCli) Do
    begin
      serviceLocal := serviceLocals.AddChild('serviceLocal');
      serviceLocal.AddChild('alternativeIdentifier').Text := ArrCli[intCnt].strCodCli;
      serviceLocal.AddChild('active').Text := 'true';

      If not ArrCli[intCnt].strRazSoc.IsEmpty Then
        serviceLocal.AddChild('description').Text :=
          ArrCli[intCnt].strCodCli +' - ' +ArrCli[intCnt].strRazSoc;

      If not ArrCli[intCnt].strRazSoc.IsEmpty Then
        serviceLocal.AddChild('corporateName').Text :=
          ArrCli[intCnt].strCodCli +' - ' +ArrCli[intCnt].strRazSoc;

      serviceLocal.AddChild('country').Text := 'Brasil';

      If not ArrCli[intCnt].strNomEst.IsEmpty
      then
        serviceLocal.AddChild('state').Text := ArrCli[intCnt].strNomEst
      else
        serviceLocal.AddChild('state');

      If not ArrCli[intCnt].strNomCid.IsEmpty
      then
        serviceLocal.AddChild('city').Text := copy(ArrCli[intCnt].strNomCid, 1, 50)
      else
        serviceLocal.AddChild('city');

      serviceLocal.AddChild('cityNeighborhood');

      If not ArrCli[intCnt].strEndere.IsEmpty Then
      Begin
        strEndereco := ArrCli[intCnt].strEndere;

        strNumero := Trim(SplitString(strEndereco, ',')[Length(SplitString(strEndereco, ','))-1]);
        strEndereco := SplitString(strEndereco, ',')[0];

        If TryStrToInt(strNumero, intTst) And
           (intTentativa = 0) Then
        Begin
          serviceLocal.AddChild('street').Text := strEndereco;
          serviceLocal.AddChild('streetNumber').Text := strNumero;
        End
        Else If intTentativa = 0 Then
        Begin
          serviceLocal.AddChild('street').Text := copy(ArrCli[intCnt].strEndere, 1, 100);
          serviceLocal.AddChild('streetNumber');
        End
        Else If intTentativa = 1 Then
        Begin
          serviceLocal.AddChild('street').Text := copy(strEndereco, 1, 100);
          serviceLocal.AddChild('streetNumber');
        End
        Else
        Begin
          strEndereco := fRetEnderecoCEP(ArrCli[intCnt].strC_e_p_);

          If strEndereco <> '' Then
            serviceLocal.AddChild('street').Text := strEndereco
          Else
            serviceLocal.AddChild('street');

          serviceLocal.AddChild('streetNumber').Text := '';
        End;
      End;

      If (not ArrCli[intCnt].strComple.IsEmpty) And
             (intTentativa = 0) Then
        serviceLocal.AddChild('streetComplement').Text := copy(ArrCli[intCnt].strComple, 1, 50)
      Else
        serviceLocal.AddChild('streetComplement');

      If not ArrCli[intCnt].strC_e_p_.IsEmpty Then
        serviceLocal.AddChild('zipCode').Text := ArrCli[intCnt].strC_e_p_;

      If not ArrCli[intCnt].strCelula.IsEmpty Then
      Begin
        serviceLocal.AddChild('cellphoneStd').Text := LeftStr(ArrCli[intCnt].strCelula, 2);
        serviceLocal.AddChild('cellphoneNumber').Text := Trim(Copy(ArrCli[intCnt].strCelula, 3, Length(ArrCli[intCnt].strCelula)));
      End;

      If fValidaTelefone(ArrCli[intCnt].strFone01) Then
      Begin
        serviceLocal.AddChild('phoneStd').Text := LeftStr(ArrCli[intCnt].strFone01, 2);
        serviceLocal.AddChild('phoneNumber').Text := Trim(Copy(ArrCli[intCnt].strFone01, 3, Length(ArrCli[intCnt].strFone01)));
      End;

      If (not ArrCli[intCnt].strE_mail.IsEmpty) And (Length(ArrCli[intCnt].strE_mail) <= 50) Then
        serviceLocal.AddChild('email').Text := ArrCli[intCnt].strE_mail;

      If not ArrCli[intCnt].strCpfCnp.IsEmpty Then
      Begin
        customFields := serviceLocal.AddChild('customFields');
        customFields.AddChild('CNPJ__CPF').Text := ArrCli[intCnt].strCpfCnp;
      End;
    End;

    If blnLogar Then
      pSaveXML(xml);

    Result := fGetDataString(xml);
  Finally
  End;
end;

function fXMLNotasFiscais(arrNF: TarrNF): String;
  Var
    xml: TXMLDocument;
    customEntityEntries: IXMLNode;
    customEntityEntry: IXMLNode;
    customFields: IXMLNode;
    clientesCustomField: IXMLNode;
    intCnt : Integer;
begin
  xml := TXMLDocument.Create(Nil);
  Try
    xml.Active := True;

    customEntityEntries := xml.AddChild('customEntityEntries');

    For intCnt := Low(arrNF) To High(arrNF) Do
    begin
      customEntityEntry := customEntityEntries.AddChild('customEntityEntry');
      customEntityEntry.AddChild('alternativeIdentifier').Text := arrNF[intCnt].strNumDoc;
      customEntityEntry.AddChild('description').Text := arrNF[intCnt].strNumDoc;
      customEntityEntry.AddChild('active').Text := 'true';

      customFields := customEntityEntry.AddChild('customFields');
      customFields.AddChild('NUM_ROMANEIO').Text := arrNF[intCnt].strNumRom;
      customFields.AddChild('COD_CLIENTE').Text := arrNF[intCnt].strCodCli;
      customFields.AddChild('PAIS_DADOS_NF').Text := arrNF[intCnt].strPaisNF;
      customFields.AddChild('ESTADO_DADOS_NF').Text := arrNF[intCnt].strEstado;
      customFields.AddChild('MUNICIPIO_DADOS_NF').Text := arrNF[intCnt].strCidade;
      customFields.AddChild('BAIRRO_DADOS_NF').Text := arrNF[intCnt].strBairNF;
      customFields.AddChild('TIPO_LOGRADOURO_DADOS_NF').Text := arrNF[intCnt].strTipEnd;
      customFields.AddChild('LOGRADOURO_DADOS_NF').Text := arrNF[intCnt].strEndere;
      customFields.AddChild('NUM_LOGRADOURO_DADOS_NF').Text := arrNF[intCnt].strNumEnd;
      customFields.AddChild('COMPLEMENTO_DADOS_NF').Text := arrNF[intCnt].strComple;
      customFields.AddChild('CEP_DADOS_NF').Text := arrNF[intCnt].strC_e_p_;
      customFields.AddChild('DATA_ENTREGA').Text := FormatDateTime('yyyy-mm-dd', arrNF[intCnt].dtaDtaEmi);
      customFields.AddChild('DATA_EMISSAO_NF').Text := FormatDateTime('yyyy-mm-dd', arrNF[intCnt].dtaDtaEmi);
      customFields.AddChild('exibe_nota').Text := 'S';

      clientesCustomField := customFields.AddChild('clientes');
      clientesCustomField.AddChild('alternativeIdentifier').Text := arrNF[intCnt].strCodCli;
    End;

    If blnLogar Then
      pSaveXML(xml);

    Result := fGetDataString(xml);
  Finally
  End;
end;

function fXMLItensNotasFiscais(arrIteNF: TArrIteNF): String;
  Var
    xml: TXMLDocument;
    customEntityEntries: IXMLNode;
    customEntityEntry: IXMLNode;
    customFields: IXMLNode;
    intCnt : Integer;
begin
  xml := TXMLDocument.Create(Nil);
  Try
    xml.Active := True;

    customEntityEntries := xml.AddChild('customEntityEntries');

    For intCnt := Low(arrIteNF) To High(arrIteNF) Do
    begin
      customEntityEntry := customEntityEntries.AddChild('customEntityEntry');
      customEntityEntry.AddChild('alternativeIdentifier').Text := arrIteNF[intCnt].strNumDoc;
      customEntityEntry.AddChild('description').Text := arrIteNF[intCnt].strNumDoc;

      customFields := customEntityEntry.AddChild('customFields');
      customFields.AddChild('NUMERO_NOTA_FISCAL').Text := arrIteNF[intCnt].strNumDoc;
      customFields.AddChild('CODIGO_PRODUTO').Text := arrIteNF[intCnt].strCodIte;
      customFields.AddChild('QTDE_PRODUTO').Text := fFloatToStrPonto(arrIteNF[intCnt].fltQtdIte, 12, fCfgSis('DECQTD', varInteger));
    End;

    If blnLogar Then
      pSaveXML(xml);

    Result := fGetDataString(xml);
  Finally
  End;
end;

function fXMLItemNotasFiscais(recIteNF: TrecIteNF): String;
  Var
    xml: TXMLDocument;
    customEntityEntry: IXMLNode;
    customFields: IXMLNode;
begin
  xml := TXMLDocument.Create(Nil);
  Try
    xml.Active := True;

    customEntityEntry := xml.AddChild('customEntityEntry');
    customEntityEntry.AddChild('alternativeIdentifier').Text := recIteNF.strDescription;
    customEntityEntry.AddChild('description').Text := recIteNF.strDescription;

    customFields := customEntityEntry.AddChild('customFields');
    customFields.AddChild('NUMERO_NOTA_FISCAL').Text := recIteNF.strNumDoc;
    customFields.AddChild('CODIGO_PRODUTO').Text := recIteNF.strCodIte;
    customFields.AddChild('QTDE_PRODUTO').Text := fFloatToStrPonto(recIteNF.fltQtdIte, 12, fCfgSis('DECQTD', varInteger));

    If blnLogar Then
      pSaveXML(xml);

    Result := fGetDataString(xml);
  Finally
  End;
end;

function fXMLItens(arrIte: TarrIte): String;
  Var
    xml: TXMLDocument;
    items: IXMLNode;
    item: IXMLNode;
    customFields: IXMLNode;
    subGroup: IXMLNode;
    intCnt : Integer;
begin
  xml := TXMLDocument.Create(Nil);
  Try
    xml.Active := True;

    items := xml.AddChild('items');

    For intCnt := Low(arrIte) To High(arrIte) Do
    begin
      item := items.AddChild('item');
      item.AddChild('alternativeIdentifier').Text := arrIte[intCnt].strCodIte;
      item.AddChild('description').Text := arrIte[intCnt].strDesIte;
      item.AddChild('active').Text := IIF(arrIte[intCnt].blnIteAti, 'true', 'false');
      subGroup := item.AddChild('subGroup');
      subGroup.AddChild('alternativeIdentifier').Text := arrIte[intCnt].strLinGru;

      customFields := item.AddChild('customFields');
      customFields.AddChild('CODIGO__EAN').Text := arrIte[intCnt].strCodEan;
      customFields.AddChild('PRECO__UNITARIO').Text := fFloatToStrPonto(arrIte[intCnt].fltUnitar, 12, fCfgSis('DECUNI', varInteger));
      customFields.AddChild('UNIDADE').Text := arrIte[intCnt].strUnidad;
      //customFields.AddChild('ITE__DESCONTO__MAXIMO').Text := arrIte[intCnt].strPaisNF;
      //customFields.AddChild('CODIGO__DUN14').Text := arrIte[intCnt].strCodCli;
    End;

    If blnLogar Then
      pSaveXML(xml);

    Result := fGetDataString(xml);
  Finally
  End;
end;

function fXMLGrupo(recLinGru: TrecLinGru): String;
  Var
    xml: TXMLDocument;
    group: IXMLNode;
begin
  xml := TXMLDocument.Create(Nil);
  Try
    xml.Active := True;

    group := xml.AddChild('group');
    group.AddChild('alternativeIdentifier').Text := recLinGru.strCodigo;
    group.AddChild('description').Text := recLinGru.strDescri;
    group.AddChild('active').Text := 'true';

    If blnLogar Then
      pSaveXML(xml);

    Result := fGetDataString(xml);
  Finally
  End;
end;

function fXMLAtualizaGrupo(recLinGru: TrecLinGru): String;
  Var
    xml: TXMLDocument;
    group: IXMLNode;
begin
  xml := TXMLDocument.Create(Nil);
  Try
    xml.Active := True;

    group := xml.AddChild('group');
    group.AddChild('description').Text := recLinGru.strDescri;

    If blnLogar Then
      pSaveXML(xml);

    Result := fGetDataString(xml);
  Finally
  End;
end;

function fXMLSubGrupo(recLinGru: TrecLinGru): String;
  Var
    xml: TXMLDocument;
    subGroup: IXMLNode;
    group: IXMLNode;
begin
  xml := TXMLDocument.Create(Nil);
  Try
    xml.Active := True;

    subGroup := xml.AddChild('subGroup');
    subGroup.AddChild('alternativeIdentifier').Text := recLinGru.strCodigo;
    subGroup.AddChild('description').Text := recLinGru.strDescri;
    subGroup.AddChild('active').Text := 'true';
    group := subGroup.AddChild('group');
    group.AddChild('alternativeIdentifier').Text := LeftStr(recLinGru.strCodigo, 3) + '000';

    If blnLogar Then
      pSaveXML(xml);

    Result := fGetDataString(xml);
  Finally
  End;
end;

function fAtualizaSubGrupo(recLinGru: TrecLinGru): String;
  Var
    xml: TXMLDocument;
    subGroup: IXMLNode;
begin
  xml := TXMLDocument.Create(Nil);
  Try
    xml.Active := True;

    subGroup := xml.AddChild('subGroup');
    subGroup.AddChild('description').Text := recLinGru.strDescri;

    If blnLogar Then
      pSaveXML(xml);

    Result := fGetDataString(xml);
  Finally
  End;
end;

function fGetDataString(xml: TXMLDocument): String;
  Var
    Stream : TStringStream;
begin
  Stream := TStringStream.Create('', TEncoding.UTF8);
  Try
    xml.SaveToStream(Stream);
    Result := Stream.DataString;
  Finally
    FreeAndNil(Stream);
  End;
end;

procedure pSaveXML(xml: TXMLDocument);
  Var
    strDir : String;
begin
  If (blnLogar) Then
  Begin
    strDir := ExtractFilePath(Application.ExeName) + 'uMovMeLogs\';
    If Not DirectoryExists(strDir) Then
      ForceDirectories(strDir);
    xml.SaveToFile(strDir + FormatDateTime('yyyymmdd_hhnnsszzz', fNow) + '.xml');
  End;
end;

function fXMLSchedules(arrSchedules: TArrSchedules): String;
Var
  xml: TXMLDocument;
  schedules,
  schedule,
  agent,
  serviceLocal,
  customFields: IXMLNode;
  intCnt : Integer;
begin
  xml := TXMLDocument.Create(Nil);
  Try
    xml.Active := True;

    schedules := xml.AddChild('schedules');

    For intCnt := Low(arrSchedules) To High(arrSchedules) Do
    Begin
      schedule := schedules.AddChild('schedule');
      schedule.AddChild('active').Text := IIF(arrSchedules[intCnt].blnActive, 'true', 'false');
      schedule.AddChild('alternativeIdentifier').Text := arrSchedules[intCnt].strAlternativeIdentifier;
      schedule.AddChild('date').Text := arrSchedules[intCnt].strDate;
      schedule.AddChild('hour').Text := arrSchedules[intCnt].strHour;

      agent := schedule.AddChild('agent');
      agent.AddChild('id').Text := arrSchedules[intCnt].strAgent;

      serviceLocal := schedule.AddChild('serviceLocal');
      serviceLocal.AddChild('alternativeIdentifier').Text := arrSchedules[intCnt].strServiceLocal;

      schedule.AddChild('activitiesOrigin').Text := arrSchedules[intCnt].strActivitiesOrigin;

      customFields := schedule.AddChild('customFields');

      customFields.AddChild('PLACA__VEICULO').Text := arrSchedules[intCnt].strPlaVei;
      customFields.AddChild('NUM__NOTAFISCAL__TAREFA').Text := arrSchedules[intCnt].strNF;
    End;

    If blnLogar Then
        pSaveXML(xml);

    Result := fGetDataString(xml);
  Finally
  End;
end;

function fXMLScheduleItems(arrScheduleItems: TArrScheduleItems): String;
Var
  xml: TXMLDocument;
  scheduleItems,
  scheduleItem,
  item,
  schedule,
  customFields: IXMLNode;
  intCnt :Integer;
begin
  xml := TXMLDocument.Create(Nil);
  Try
    xml.Active := True;

    scheduleItems := xml.AddChild('scheduleItems');

    For intCnt := Low(arrScheduleItems) To High(arrScheduleItems) Do
    Begin
      scheduleItem := scheduleItems.AddChild('scheduleItem');

      item := scheduleItem.AddChild('item');
      item.AddChild('alternativeIdentifier').Text := arrScheduleItems[intCnt].strItemId;

      schedule := scheduleItem.AddChild('schedule');
      schedule.AddChild('alternativeIdentifier').Text := arrScheduleItems[intCnt].strScheduleAltId;

      customFields := scheduleItem.AddChild('customFields');
      customFields.AddChild('QTDE__PRODUTO').Text := arrScheduleItems[intCnt].strCustomQtdProd;
      customFields.AddChild('NUMERO__NOTA__FISCAL').Text := arrScheduleItems[intCnt].strCustomNroNF;
      
      If blnLogar Then
        pSaveXML(xml);
    End;

    Result := fGetDataString(xml);
  Finally
  End;
end;


function fXMLScheduleRouting(recScheduleRouting: TrecScheduleRouting): String;
Var
  xml: TXMLDocument;
  route,
  origin,
  agent,
  schedules,
  schedule: IXMLNode;
  intCnt :Integer;
begin
  xml := TXMLDocument.Create(Nil);
  Try
    xml.Active := True;

    route := xml.AddChild('route');
    route.AddChild('route').Text := 'true';

    origin := route.AddChild('origin');

    If fCfgSis('GEOORI') = '' Then
    Begin
      agent := origin.AddChild('agent');
      agent.AddChild('id').Text := recScheduleRouting.agentId;
    End
    Else
      origin.AddChild('geoCoordinate').Text := fCfgSis('GEOORI');

    origin.AddChild('transportMode').Text := '0';

    route.AddChild('updateSchedules').Text := 'true';
    route.AddChild('startTime').Text := FormatDateTime('yyyy-mm-dd hh:mm:ss', fNow);
    route.AddChild('estimate').Text := 'true';

    schedules := route.AddChild('schedules');

    For intCnt := Low(recScheduleRouting.arrScheduleIds) To High(recScheduleRouting.arrScheduleIds) Do
    Begin
      schedule := schedules.AddChild('schedule');

      schedule.AddChild('id').Text :=
        recScheduleRouting.arrScheduleIds[intCnt];
    End;

    If blnLogar Then
        pSaveXML(xml);

    Result := fGetDataString(xml);
  Finally
  End;
end;

function fBuscarXML(strXML, strTag :String) :String;
  function fPesquisaXML(var Node: IXMLNode; Campo: string; out Valor: Variant): Boolean;
  var
    index: integer;
    Node_Tmp: IXMLNode;
  begin
     Result := False;
     for Index := 0 to Node.ChildNodes.Count - 1 do
     begin
        Node_Tmp := Node.ChildNodes[Index];
        if SameText(Node_Tmp.NodeName, Campo) then
        begin
           Result := True;
           Valor := Node_Tmp.NodeValue;
           Exit;
        end
        else if Node_Tmp.ChildNodes.Count > 0 then
        begin
           Result := fPesquisaXML(Node_Tmp, Campo, Valor);
           if Result then
              Exit;
        end;
     end;
  end;

var
  Node_Geral: IXMLNode;
  res: Variant;
  XML :IXMLDocument;
begin
  Result := '';

  try
     XML := LoadXMLData(strXML);
     XML.Active := True;
     Node_Geral := XML.DocumentElement;
     if fPesquisaXML(Node_Geral, strTag, res)  then
     begin
      If res <> null Then
      Begin
        SetLength(Result, Length(res));
        Result := VarToStr(res);
      End
      Else
        Result := '';
     end
     else
        Result := '';
  finally
  end;
end;

initialization
  blnLogar := FileExists('uMovMe.debug');

end.
