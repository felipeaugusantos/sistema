unit untBragancaPaulistaXML;

interface

uses
{$IF Defined(LINUX)}
  untUniClientDataSet,
{$ELSE}
  {$IF Defined(UNIDAC)}
    UniClientDataSet, Uni, MySQLUniProvider, UniProvider,
  {$ELSE}
   ZConnection, ZDataset, ZDbcIntfs,
  {$IFEND}
  Windows, Messages, Graphics, Controls, Forms,
  ComCtrls, StdCtrls, ExtCtrls, DBCtrls, MemDS, Dialogs,
  frxClass, frxBarcode, frxDBSet, frxDelphiZXingQRCode,
  frxDesgn, untUniClientDataSet,
{$IFEND}
  SysUtils, Variants, Classes, StrUtils, untConexaoBD,
  untUtil, XMLIntf, XMLDoc, DB, DBClient;

type
  TBragancaPaulistaXML = class

    private
    public
      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS : TUniClientDataSet; strXML: string);
      class procedure pCarregaTagPrincipal(const ATagPrincipalValidacao : IXMLNode;  var ATagPrincipalRetorno : IXMLNode);
      class function fGetValorXml(nodNo: IXMLNode; strNome: String; varTipVar: TVarType = varString;
        strDateFormat: String = 'YYYY-MM-DD'; chrDateSeparator: Char = '-'; blnDateTime: Boolean = False): Variant;
  end;

implementation

{ TBragancaPaulistaXML }

class function TBragancaPaulistaXML.fGetValorXml(nodNo: IXMLNode; strNome: String; varTipVar: TVarType = varString;
  strDateFormat: String = 'YYYY-MM-DD'; chrDateSeparator: Char = '-'; blnDateTime: Boolean = False): Variant;
  Var
    nodRec: IXMLNode;
    forSet: TFormatSettings;
    strData: String;
Begin
  With nodNo Do
  Begin
    forSet := TFormatSettings.Create;
    forSet.ShortDateFormat := strDateFormat;
    forSet.DateSeparator   := chrDateSeparator;

    nodRec := ChildNodes.FindNode(strNome);

    If Assigned(nodRec) Then
    Begin

      Try
        Case varTipVar Of

          varDate  :  Begin
                        If nodRec.NodeValue = Null Then
                          Result := 0

                        Else If blnDateTime Then
                        Begin
                          strData := LeftStr(nodRec.NodeValue, 10);
                          Result  := StrToDate(strData, forSet);
                        End Else
                        Begin
                          Try
                            Result  := StrToDate(nodRec.NodeValue, forSet);
                          Except
                            Result  := 0;
                          End;
                        End;

                      End;

          varString:  Begin
                        If nodRec.NodeValue = Null Then
                          Result := ''
                        Else
                          Result := nodRec.NodeValue;
                      End;

          varDouble:  Begin
                        If nodRec.NodeValue = Null Then
                          Result := 0
                        Else
                          Result := fStrToFloat(AnsiReplaceStr(nodRec.NodeValue,'.',','));
                      End;

          varInteger: Begin
                        If nodRec.NodeValue = Null Then
                          Result := 0
                        Else
                          Result := nodRec.NodeValue;
                      End;

        End;
      Except
        Raise Exception.Create('Erro ao ler valor ' + strNome);
      End;

    End Else
    Begin
      Case varTipVar Of
        varDate:     Result := 0;
        varString:   Result := '';
        varDouble:   Result := 0;
        varInteger:  Result := 0;
      End;
    End;

  End;
End;

class procedure TBragancaPaulistaXML.pCarregaTagPrincipal(const ATagPrincipalValidacao : IXMLNode;  var ATagPrincipalRetorno : IXMLNode);
begin
  ATagPrincipalRetorno := ATagPrincipalValidacao;
end;

class procedure TBragancaPaulistaXML.pRetornaCDSPreenchidoComENotas(
  var cdsNFS: TUniClientDataSet; strXML: string);
var
  NoInfNfse : IXMLDocument;
  dtDataVenIss : TDate;
  wDia, wMes, wAno : Word;
  nodReg20Item, nodReg60, nodGIBSCBS, nodItem : IXMLNode;
  I : integer;
  intIdTrib  : integer;
  fltAliq    : double;
  fltPercRed : double;
  fltAlqEfet : double;
  fltVlTrib  : double;

begin
  NoInfNfse := TXMLDocument.Create(Application);

  NoInfNfse.LoadFromXML(strXML);
  NoInfNfse.Active := True;
  cdsNFS.Append;

  nodReg20Item := NoInfNfse.ChildNodes.FindNode('Reg20Item');
  If Assigned(nodReg20Item) And Assigned(nodReg20Item.ChildNodes.FindNode('DtEmiRps')) Then
    dtDataVenIss := StrToDate(nodReg20Item.ChildNodes['DtEmiRps'].Text)
  Else
    dtDataVenIss := Date;

  DecodeDate(dtDataVenIss, wAno, wMes, wDia);
  If wMes = 12 Then
  Begin
    dtDataVenIss := EncodeDate(wAno + 1, 01, 14);
  End
  Else
  Begin
    dtDataVenIss := EncodeDate(wAno, wMes + 1, 14);
  End;

  cdsNFS.FieldByName('DTVENISS').AsString := DateToStr(dtDataVenIss);

  cdsNFS.FieldByName('NUMNFS').AsString   := RetornaTexto(strXML, '<NumNf>', '</NumNf>');
  cdsNFS.FieldByName('SERNFE').AsString   := RetornaTexto(strXML, '<SerNf>', '</SerNf>');
  cdsNFS.FieldByName('CODVER').AsString   := RetornaTexto(strXML, '<CodVernf>', '</CodVernf>');
  cdsNFS.FieldByName('DTAEMI').AsString   := RetornaTexto(strXML, '<DtHrGerNf>', '</DtHrGerNf>');
  cdsNFS.FieldByName('SERRPS').AsString   := RetornaTexto(strXML, '<SerRps>', '</SerRps>');
  cdsNFS.FieldByName('NUMRPS').AsString   := RetornaTexto(strXML, '<NumRps>', '</NumRps>');
  cdsNFS.FieldByName('EMIRPS').AsString   := RetornaTexto(strXML, '<DtEmiRps>', '</DtEmiRps>');

  //prestador
  cdsNFS.FieldByName('PSVCNPJ').AsString  := RetornaTexto(strXML, '<CpfCnpjPre>', '</CpfCnpjPre>');
  cdsNFS.FieldByName('PSVRAZAO').AsString := RetornaTexto(strXML, '<RazSocPre>', '</RazSocPre>');
  cdsNFS.FieldByName('PSVEND').AsString   := RetornaTexto(strXML, '<LogPre>', '</LogPre>');
  cdsNFS.FieldByName('PSVNUM').AsString   := RetornaTexto(strXML, '<NumEndPre>', '</NumEndPre>');
  cdsNFS.FieldByName('PSVBAI').AsString   := RetornaTexto(strXML, '<BairroPre>', '</BairroPre>');
  cdsNFS.FieldByName('PSVCID').AsString   := RetornaTexto(strXML, '<MunPre>', '</MunPre>');
  cdsNFS.FieldByName('PSVUF').AsString    := RetornaTexto(strXML, '<SiglaUFPre>', '</SiglaUFPre>');
  cdsNFS.FieldByName('PSVCEP').AsString   := RetornaTexto(strXML, '<CepPre>', '</CepPre>');
  cdsNFS.FieldByName('PSVFONE').AsString  := '';
  cdsNFS.FieldByName('PSVIE_').AsString   := '';
  cdsNFS.FieldByName('PSVIM').AsString    := '';

  //tomador
  cdsNFS.FieldByName('TOMCNPJ').AsString  := RetornaTexto(strXML, '<CpfCnpjTom>', '</CpfCnpjTom>');
  cdsNFS.FieldByName('TOMRAZAO').AsString := RetornaTexto(strXML, '<RazSocTom>', '</RazSocTom>');
  cdsNFS.FieldByName('TOMEND').AsString   := RetornaTexto(strXML, '<LogTom>', '</LogTom>');
  cdsNFS.FieldByName('TOMNUM').AsString   := RetornaTexto(strXML, '<NumEndTom>', '</NumEndTom>');
  cdsNFS.FieldByName('TOMCOM').AsString   := RetornaTexto(strXML, '<ComplEndTom>', '</ComplEndTom>');
  cdsNFS.FieldByName('TOMBAI').AsString   := RetornaTexto(strXML, '<BairroTom>', '</BairroTom>');
  cdsNFS.FieldByName('TOMCID').AsString   := RetornaTexto(strXML, '<MunTom>', '</MunTom>');
  cdsNFS.FieldByName('TOMUF').AsString    := RetornaTexto(strXML, '<SiglaUFTom>', '</SiglaUFTom>');
  cdsNFS.FieldByName('TOMCEP').AsString   := RetornaTexto(strXML, '<CepTom>', '</CepTom>');
  cdsNFS.FieldByName('TOMEMA').AsString   := RetornaTexto(strXML, '<EMailTom>', '</EMailTom>');
  cdsNFS.FieldByName('TMSIM').AsString    := '';
  cdsNFS.FieldByName('TMSIE').AsString    := '';

  //local prestacao
  cdsNFS.FieldByName('LOCPRE').AsString   := RetornaTexto(strXML, '<LogLocPre>', '</LogLocPre>');
  cdsNFS.FieldByName('LOCNUM').AsString   := RetornaTexto(strXML, '<NumEndLocPre>', '</NumEndLocPre>');
  cdsNFS.FieldByName('LOCBAI').AsString   := RetornaTexto(strXML, '<BairroLocPre>', '</BairroLocPre>');
  cdsNFS.FieldByName('LOCMUN').AsString   := RetornaTexto(strXML, '<MunLocPre>', '</MunLocPre>');
  cdsNFS.FieldByName('LOC_UF').AsString   := RetornaTexto(strXML, '<SiglaUFLocpre>', '</SiglaUFLocpre>');
  cdsNFS.FieldByName('LOCCEP').AsString   := RetornaTexto(strXML, '<CepLocPre>', '</CepLocPre>');

  cdsNFS.FieldByName('DISSER').AsString   := RetornaTexto(strXML, '<DiscrSrv>', '</DiscrSrv>');
  cdsNFS.FieldByName('CODSER').AsString   := RetornaTexto(strXML, '<CodSrv>', '</CodSrv>');
  cdsNFS.FieldByName('DISCRDED').AsString := RetornaTexto(strXML, '<DiscrDed>', '</DiscrDed>');

  //valores
  cdsNFS.FieldByName('VLRSER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<VlNFS>', '</VlNFS>'),'.',','), 0);
  cdsNFS.FieldByName('VLRDED').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<VlDed>', '</VlDed>'),'.',','), 0);
  cdsNFS.FieldByName('BASCAL').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<VlBasCalc>', '</VlBasCalc>'),'.',','), 0);
  cdsNFS.FieldByName('ALISER').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<AlqIss>', '</AlqIss>'),'.',','), 0);
  cdsNFS.FieldByName('VLRISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<VlIss>', '</VlIss>'),'.',','), 0);
  cdsNFS.FieldByName('VLISSR').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<VlIssRet>', '</VlIssRet>'),'.',','), 0);

  cdsNFS.FieldByName('TRISIG').AsString := RetornaTexto(strXML, '<TributoSigla>', '</TributoSigla>');
  cdsNFS.FieldByName('TRIALI').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<TributoAliquota>', '</TributoAliquota>'),'.',','), 0);
  cdsNFS.FieldByName('TRIVAL').AsFloat    := StrToFloatDef(AnsiReplaceStr(RetornaTexto(strXML, '<TributoValor>', '</TributoValor>'),'.',','), 0);

  nodReg20Item := NoInfNfse.ChildNodes.FindNode('Reg20Item');
  If Assigned(nodReg20Item) Then
    pCarregaTagPrincipal(nodReg20Item.ChildNodes.FindNode('Reg60'), nodReg60)
  Else
    nodReg60 := nil;

  If Assigned(nodReg60) Then
  Begin

    cdsNFS.FieldByName('gIBSCBS_CST').AsString        := fGetValorXml(nodReg60, 'Cst',         varString);
    cdsNFS.FieldByName('gIBSCBS_cClassTrib').AsString := fGetValorXml(nodReg60, 'CClassTrib',  varString);
    cdsNFS.FieldByName('IBSCBS_cIndOp').AsString      := '';
    cdsNFS.FieldByName('MUNINC').AsString             := fGetValorXml(nodReg60, 'LocalIdInc',  varString);
    cdsNFS.FieldByName('BC____').AsFloat              := fGetValorXml(nodReg60, 'BaseCalc',    varDouble);

    // nodReg60 já apontando para o nó <Reg60>
    nodGIBSCBS := nodReg60.ChildNodes.FindNode('GIBSCBS');

    If Assigned(nodGIBSCBS) Then
    Begin
      For i := 0 To nodGIBSCBS.ChildNodes.Count - 1 Do
      Begin
        nodItem := nodGIBSCBS.ChildNodes[i];

        If nodItem.NodeName = 'GIBSCBSItem' Then
        Begin
          intIdTrib  := fGetValorXml(nodItem, 'IdTrib',  varInteger);
          fltAliq    := fGetValorXml(nodItem, 'Aliq',    varDouble);
          fltPercRed := fGetValorXml(nodItem, 'PercRed', varDouble);
          fltAlqEfet := fGetValorXml(nodItem, 'AlqEfet', varDouble);
          fltVlTrib  := fGetValorXml(nodItem, 'VlTrib',  varDouble);

          Case intIdTrib Of
            1: Begin
                 cdsNFS.FieldByName('CBS___').asFloat      := fltAliq;
                 cdsNFS.FieldByName('RedAliqCBS').asFloat  := fltPercRed;
                 cdsNFS.FieldByName('AliqEfetCBS').asFloat := fltAlqEfet;
                 cdsNFS.FieldByName('gCBS_vCBS').asFloat   := fltVlTrib;
               End;
            2: Begin
                 cdsNFS.FieldByName('IBSUF_').asFloat      := fltAliq;
                 cdsNFS.FieldByName('RedAliqUF').asFloat   := fltPercRed;
                 cdsNFS.FieldByName('AliqEfetUF').asFloat  := fltAlqEfet;
                 cdsNFS.FieldByName('gIBS_vIBSUF').asFloat := fltVlTrib;
               End;
            3: Begin
                 cdsNFS.FieldByName('IBSMun').asFloat       := fltAliq;
                 cdsNFS.FieldByName('RedAliqMun').asFloat   := fltPercRed;
                 cdsNFS.FieldByName('AliqEfetMun').asFloat  := fltAlqEfet;
                 cdsNFS.FieldByName('gIBS_vIBSMun').asFloat := fltVlTrib;
               End;
          End;
        End;
      End;
    End;
  end;

  cdsNFS.Post;
end;

end.
