unit untCaxiasDoSulXML;

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
  TCaxiasDoSulXML = class

  private

  public
      class function fNoElemento(strXML: string): IXMLNode;
      class function fNoinfNFSe(NoElemento: IXMLNode): IXMLNode;
      class function fNoFatura(NoinfNFSe: IXMLNode): IXMLNode;
      class function fNoFaT(NoFatura: IXMLNode): IXMLNode;

      class procedure pRetornaCDSPreenchidoComENotas(var cdsNFS, cdsFaturas: TUniClientDataSet; strXML: string);

  end;

implementation

{ TCaxiasDoSulXML }

class function TCaxiasDoSulXML.fNoElemento(strXML: string): IXMLNode;
var
  XmlDoc : IXMLDocument;
begin

  XmlDoc := TXMLDocument.Create(Application);
  XmlDoc.LoadFromXML(strXML);
  XmlDoc.Active := True;

  Result := XmlDoc.DocumentElement;
end;

class function TCaxiasDoSulXML.fNoFaT(NoFatura: IXMLNode): IXMLNode;
begin
  If NoFatura <> Nil Then
    Result := NoFatura.ChildNodes.FindNode('fat');
end;

class function TCaxiasDoSulXML.fNoFatura(NoinfNFSe: IXMLNode): IXMLNode;
begin
  If NoinfNFSe <> Nil Then
    Result := NoinfNFSe.ChildNodes.FindNode('faturas');
end;

class function TCaxiasDoSulXML.fNoinfNFSe(NoElemento: IXMLNode): IXMLNode;
begin
  If NoElemento <> Nil Then
    Result := NoElemento.ChildNodes.FindNode('infNFSe');
end;

class procedure TCaxiasDoSulXML.pRetornaCDSPreenchidoComENotas(var cdsNFS,
  cdsFaturas: TUniClientDataSet; strXML: string);
var
  XmlDoc : IXMLDocument;
  NoElemento,
  NoinfNFSe,
  NoFaturas,
  NoFat: IXMLNode;
begin
  NoElemento := fNoElemento(strXML);
  NoinfNFSe  := fNoinfNFSe(NoElemento);
  NoFaturas  := fNoFatura(NoinfNFSe);
  NoFat      := fNoFaT(NoFaturas);

  If NoinfNFSe <> Nil Then
  Begin

    cdsNFS.Append;

    //DADOS DA NOTA FISCAO DE SERVIÇO ELETRÔNICA E RPS
    cdsNFS.FieldByName('SERIE').AsString    := NoinfNFSe.ChildNodes['Id'].ChildNodes['serie'].Text;
    cdsNFS.FieldByName('NUMNFS').AsString   := NoinfNFSe.ChildNodes['Id'].ChildNodes['nNFS-e'].Text;

    cdsNFS.FieldByName('DTAEMI').AsString   := Copy(NoinfNFSe.ChildNodes['Id'].ChildNodes['dEmi'].Text,9,2)+'/'+
                                               Copy(NoinfNFSe.ChildNodes['Id'].ChildNodes['dEmi'].Text,6,2)+'/'+
                                               Copy(NoinfNFSe.ChildNodes['Id'].ChildNodes['dEmi'].Text,1,4)+' '+
                                               NoinfNFSe.ChildNodes['Id'].ChildNodes['hEmi'].Text;

    cdsNFS.FieldByName('CHVACE').AsString   := Copy(NoinfNFSe.ChildNodes['Id'].ChildNodes['refNF'].Text,1,2)+'-'+
                                               Copy(NoinfNFSe.ChildNodes['Id'].ChildNodes['refNF'].Text,3,14)+'-'+
                                               Copy(NoinfNFSe.ChildNodes['Id'].ChildNodes['refNF'].Text,17,2)+'-'+
                                               Copy(NoinfNFSe.ChildNodes['Id'].ChildNodes['refNF'].Text,19,3)+'-'+
                                               Copy(NoinfNFSe.ChildNodes['Id'].ChildNodes['refNF'].Text,22,9)+'/'+
                                               Copy(NoinfNFSe.ChildNodes['Id'].ChildNodes['refNF'].Text,31,9);
    // Prestador
    cdsNFS.FieldByName('PSVCNPJ').AsString  := NoinfNFSe.ChildNodes['prest'].ChildNodes['CNPJ'].Text;
    cdsNFS.FieldByName('PSVRAZAO').AsString := NoinfNFSe.ChildNodes['prest'].ChildNodes['xNome'].Text;
    cdsNFS.FieldByName('PSVIM').AsString    := NoinfNFSe.ChildNodes['prest'].ChildNodes['IM'].Text;
    cdsNFS.FieldByName('PSVEMAIL').AsString := NoinfNFSe.ChildNodes['prest'].ChildNodes['xEmail'].Text;

    cdsNFS.FieldByName('PSVEND').AsString   := NoinfNFSe.ChildNodes['prest'].ChildNodes['end'].ChildNodes['xLgr'].Text;
    cdsNFS.FieldByName('PSVNUM').AsString   := NoinfNFSe.ChildNodes['prest'].ChildNodes['end'].ChildNodes['nro'].Text;
    cdsNFS.FieldByName('PSVCOMPL').AsString := NoinfNFSe.ChildNodes['prest'].ChildNodes['end'].ChildNodes['xCpl'].Text;
    cdsNFS.FieldByName('PSVBAIR').AsString  := NoinfNFSe.ChildNodes['prest'].ChildNodes['end'].ChildNodes['xBairro'].Text;
    cdsNFS.FieldByName('PSVMUN').AsString   := NoinfNFSe.ChildNodes['prest'].ChildNodes['end'].ChildNodes['cMun'].Text;
    cdsNFS.FieldByName('PSVCID').AsString   := NoinfNFSe.ChildNodes['prest'].ChildNodes['end'].ChildNodes['xMun'].Text;
    cdsNFS.FieldByName('PSVUF').AsString    := NoinfNFSe.ChildNodes['prest'].ChildNodes['end'].ChildNodes['UF'].Text;
    cdsNFS.FieldByName('PSVCEP').AsString   := NoinfNFSe.ChildNodes['prest'].ChildNodes['end'].ChildNodes['CEP'].Text;

    cdsNFS.FieldByName('PSVFONE').AsString  := NoinfNFSe.ChildNodes['prest'].ChildNodes['fone'].Text;
    cdsNFS.FieldByName('REGTRIB').AsString  := NoinfNFSe.ChildNodes['prest'].ChildNodes['regimeTrib'].Text;

    // Tomador
    cdsNFS.FieldByName('TMSCNPJ').AsString  := NoinfNFSe.ChildNodes['TomS'].ChildNodes['CNPJ'].Text;
    cdsNFS.FieldByName('TMSRAZAO').AsString := NoinfNFSe.ChildNodes['TomS'].ChildNodes['xNome'].Text;

    cdsNFS.FieldByName('TMSEND').AsString   := NoinfNFSe.ChildNodes['TomS'].ChildNodes['ender'].ChildNodes['xLgr'].Text;
    cdsNFS.FieldByName('TMSNUM').AsString   := NoinfNFSe.ChildNodes['TomS'].ChildNodes['ender'].ChildNodes['nro'].Text;
    cdsNFS.FieldByName('TMSCOMPL').AsString := NoinfNFSe.ChildNodes['TomS'].ChildNodes['ender'].ChildNodes['xCpl'].Text;
    cdsNFS.FieldByName('TMSBAIR').AsString  := NoinfNFSe.ChildNodes['TomS'].ChildNodes['ender'].ChildNodes['xBairro'].Text;
    cdsNFS.FieldByName('TMSMUN').AsString   := NoinfNFSe.ChildNodes['TomS'].ChildNodes['ender'].ChildNodes['cMun'].Text;
    cdsNFS.FieldByName('TOMCID').AsString   := NoinfNFSe.ChildNodes['TomS'].ChildNodes['ender'].ChildNodes['xMun'].Text;
    cdsNFS.FieldByName('TMSUF').AsString    := NoinfNFSe.ChildNodes['TomS'].ChildNodes['ender'].ChildNodes['UF'].Text;
    cdsNFS.FieldByName('TMSCEP').AsString   := NoinfNFSe.ChildNodes['TomS'].ChildNodes['ender'].ChildNodes['CEP'].Text;
    cdsNFS.FieldByName('TMSPAIS').AsString  := NoinfNFSe.ChildNodes['TomS'].ChildNodes['ender'].ChildNodes['xPais'].Text;

    cdsNFS.FieldByName('TMSEMAIL').AsString := NoinfNFSe.ChildNodes['TomS'].ChildNodes['xEmail'].Text;
    cdsNFS.FieldByName('TMSIE').AsString    := NoinfNFSe.ChildNodes['TomS'].ChildNodes['IE'].Text;
    cdsNFS.FieldByName('TMSFONE').AsString  := NoinfNFSe.ChildNodes['TomS'].ChildNodes['fone'].Text;
    cdsNFS.FieldByName('TMSFON2').AsString  := NoinfNFSe.ChildNodes['TomS'].ChildNodes['fone2'].Text;

    // Dados da Obra
    cdsNFS.FieldByName('OBREND').AsString   := NoinfNFSe.ChildNodes['dadosDaObra'].ChildNodes['xLogObra'].Text;
    cdsNFS.FieldByName('OBRCOMPL').AsString := NoinfNFSe.ChildNodes['dadosDaObra'].ChildNodes['xComplObra'].Text;
    cdsNFS.FieldByName('OBRNUM').AsString   := NoinfNFSe.ChildNodes['dadosDaObra'].ChildNodes['vNumeroObra'].Text;
    cdsNFS.FieldByName('OBRBAIR').AsString  := NoinfNFSe.ChildNodes['dadosDaObra'].ChildNodes['xBairroObra'].Text;
    cdsNFS.FieldByName('OBRCEP').AsString   := NoinfNFSe.ChildNodes['dadosDaObra'].ChildNodes['xCepObra'].Text;
    cdsNFS.FieldByName('OBRCID').AsString   := NoinfNFSe.ChildNodes['dadosDaObra'].ChildNodes['xCidadeObra'].Text;
    cdsNFS.FieldByName('OBRUF').AsString    := NoinfNFSe.ChildNodes['dadosDaObra'].ChildNodes['xUfObra'].Text;
    cdsNFS.FieldByName('OBRPAIS').AsString  := NoinfNFSe.ChildNodes['dadosDaObra'].ChildNodes['xPaisObra'].Text;

    // Total
    cdsNFS.FieldByName('VLRSER').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoinfNFSe.ChildNodes['total'].ChildNodes['vServ'].Text,'.',','), 0);
    cdsNFS.FieldByName('RBACAL').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoinfNFSe.ChildNodes['total'].ChildNodes['vRedBCCivil'].Text,'.',','), 0);
    cdsNFS.FieldByName('DESCONI').AsFloat   := StrToFloatDef(AnsiReplaceStr(NoinfNFSe.ChildNodes['total'].ChildNodes['vDesc'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRDED').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoinfNFSe.ChildNodes['total'].ChildNodes['vtDed'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALTOT').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoinfNFSe.ChildNodes['total'].ChildNodes['vtNF'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRLIQ').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoinfNFSe.ChildNodes['total'].ChildNodes['vtLiq'].Text,'.',','), 0);
    cdsNFS.FieldByName('TOTATRI').AsFloat   := StrToFloatDef(AnsiReplaceStr(NoinfNFSe.ChildNodes['total'].ChildNodes['totalAproxTrib'].Text,'.',','), 0);

    cdsNFS.FieldByName('VALIRR').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoinfNFSe.ChildNodes['total'].ChildNodes['Ret'].ChildNodes['vRetIR'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALPIS').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoinfNFSe.ChildNodes['total'].ChildNodes['Ret'].ChildNodes['vRetPISPASEP'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALCOF').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoinfNFSe.ChildNodes['total'].ChildNodes['Ret'].ChildNodes['vRetCOFINS'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALCSL').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoinfNFSe.ChildNodes['total'].ChildNodes['Ret'].ChildNodes['vRetCSLL'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALINS').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoinfNFSe.ChildNodes['total'].ChildNodes['Ret'].ChildNodes['vRetINSS'].Text,'.',','), 0);

    cdsNFS.FieldByName('BASCAL').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoinfNFSe.ChildNodes['total'].ChildNodes['ISS'].ChildNodes['vBCSTISS'].Text,'.',','), 0);
    cdsNFS.FieldByName('VALISS').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoinfNFSe.ChildNodes['total'].ChildNodes['ISS'].ChildNodes['vSTISS'].Text,'.',','), 0);

    cdsNFS.FieldByName('CODSER').AsString   := NoinfNFSe.ChildNodes['det'].ChildNodes['serv'].ChildNodes['cServ'].Text;
    cdsNFS.FieldByName('LCSERV').AsString   := NoinfNFSe.ChildNodes['det'].ChildNodes['serv'].ChildNodes['cLCServ'].Text;
    cdsNFS.FieldByName('DESSER').AsString   := NoinfNFSe.ChildNodes['det'].ChildNodes['serv'].ChildNodes['xServ'].Text;
    cdsNFS.FieldByName('TIPITE').AsString   := NoinfNFSe.ChildNodes['det'].ChildNodes['serv'].ChildNodes['uTrib'].Text;

    cdsNFS.FieldByName('QTDITE').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoinfNFSe.ChildNodes['det'].ChildNodes['serv'].ChildNodes['qTrib'].Text,'.',','), 0);
    cdsNFS.FieldByName('VLRUNI').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoinfNFSe.ChildNodes['det'].ChildNodes['serv'].ChildNodes['vUnit'].Text,'.',','), 0);
    cdsNFS.FieldByName('VSRVITE').AsFloat   := StrToFloatDef(AnsiReplaceStr(NoinfNFSe.ChildNodes['det'].ChildNodes['serv'].ChildNodes['vServ'].Text,'.',','), 0);
    cdsNFS.FieldByName('DESCONI').AsFloat   := StrToFloatDef(AnsiReplaceStr(NoinfNFSe.ChildNodes['det'].ChildNodes['serv'].ChildNodes['vDesc'].Text,'.',','), 0);
    cdsNFS.FieldByName('ALIQTA').AsFloat    := StrToFloatDef(AnsiReplaceStr(NoinfNFSe.ChildNodes['det'].ChildNodes['ISSST'].ChildNodes['pISSST'].Text,'.',','), 0);
    cdsNFS.FieldByName('ISSQN').AsFloat     := StrToFloatDef(AnsiReplaceStr(NoinfNFSe.ChildNodes['det'].ChildNodes['ISSST'].ChildNodes['vISSST'].Text,'.',','), 0);

    cdsNFS.FieldByName('LOCTRIB').AsString  := NoinfNFSe.ChildNodes['infAdicLT'].Text;
    cdsNFS.FieldByName('INFOADIC').AsString := NoinfNFSe.ChildNodes['infAdic'].Text;

    cdsNFS.FieldByName('CHVQRCOD').AsString := NoinfNFSe.ChildNodes['Id'].ChildNodes['refNF'].Text;

    cdsNFS.Post;

    if Assigned(cdsFaturas) and (NoFaturas <> Nil) then
    begin
      Repeat
        cdsFaturas.Append;
        cdsFaturas.FieldByName('NUMNFS').AsString := cdsNFS.FieldByName('NUMNFS').AsString;
        cdsFaturas.FieldByName('FATNUM').AsString := NoFat.ChildNodes['nFat'].Text;
        cdsFaturas.FieldByName('DTAVEN').AsString := Copy(NoFat.ChildNodes['dVenc'].Text,9,2)+'/'+
                                                     Copy(NoFat.ChildNodes['dVenc'].Text,6,2)+'/'+
                                                     Copy(NoFat.ChildNodes['dVenc'].Text,1,4);
        cdsFaturas.FieldByName('VALFAT').AsFloat  := StrToFloatDef(AnsiReplaceStr(NoFat.ChildNodes['vFat'].Text,'.',','), 0);
        cdsFaturas.Post;

        NoFat := NoFat.NextSibling;

      until NoFat = nil;
    end
    else
    begin
      cdsFaturas.Append;
      cdsFaturas.FieldByName('NUMNFS').AsString := cdsNFS.FieldByName('NUMNFS').AsString;
      cdsFaturas.FieldByName('FATNUM').AsString := '';
      cdsFaturas.FieldByName('DTAVEN').AsString := '';
      cdsFaturas.FieldByName('VALFAT').AsFloat  := 0;
      cdsFaturas.Post;
   end;

  end;
end;

end.
