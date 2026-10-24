unit untDocCupomServico;

interface

uses Classes, StrUtils, Forms, SysUtils, frxClass, frxDBSet, UniClientDataSet,
  Controls, untLeDocumento, untIFuncoes, untTypesSistema, untFuncoesSimples,
  untZClient;

type

  TLeDocumentoCupomServico = Class(TLeDocumento)
    private
      cdsCupSer: TZClient;
      Function fSQLCupSer: String;
      Function fInsereClientCupSer: Boolean;
    public
      Function fMontaClients(cdsDadosExternosMovGer: TZClient = nil; cdsDadosExternosMovDet: TZClient = nil): Boolean; override;
  End;

implementation

uses DB;

{ TLeDocumentoCupomServico }


function TLeDocumentoCupomServico.fInsereClientCupSer: Boolean;
begin
  SetLength(arrClients, Succ(Length(arrClients)));

  arrClients[High(arrClients)].cdsDados := TZClient.Create(Nil, fSQLCupSer);
  arrClients[High(arrClients)].frxDados := TfrxDBDataset.Create(Nil);
  arrClients[High(arrClients)].frxDados.DataSet  := arrClients[High(arrClients)].cdsDados.fGetDataset;
  arrClients[High(arrClients)].frxDados.Name     := 'frxMovger';
  arrClients[High(arrClients)].frxDados.UserName := 'frxMovger';

  arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('NUMDOC').AsString := recDocume.strNumDoc;
  arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('ESPDOC').AsString := recDocume.strEspDoc;
  arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('CODEMP').AsString := recDocume.strCodEmp;

  Result := arrClients[High(arrClients)].cdsDados.fAbreClient(True, 'fInsereClientRomGer');
end;

function TLeDocumentoCupomServico.fMontaClients(cdsDadosExternosMovGer,
  cdsDadosExternosMovDet: TZClient): Boolean;
begin
  Try
    Result := True;

    Result    := Result And fInsereClientCupSer;
    cdsCupSer := arrClients[0].cdsDados;

    If Not Result Then
      Exit;

    Result := Result And fInsereClientEmpresa;

    {If (recDocume.opcAgrupaPor = opcNaoAgrupa) Then
      recDocume.strCodCli := EmptyStr;}

    Result := Result And fInsereClientCliente;

    Result := Result and fInsereClientEnderecoEntrega('AUTOINCREM', 'ROMGERX', '');

    Result := Result And fPreparaImpressaoDocumentos;

    If Result Then pSetaOrdenacao;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fMontaClients]');
    End;
  End;
end;

function TLeDocumentoCupomServico.fSQLCupSer: String;
var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT CONCAT(                                                           ';
  strSQL := strSQL + '        IF(GER_CODS01 IS NOT NULL, CONCAT(GER_CODS01, "<<csq>>"), ""),    ';
  strSQL := strSQL + '        IF(GER_CODS02 IS NOT NULL, CONCAT(GER_CODS02, "<<csq>>"), ""),    ';
  strSQL := strSQL + '        IF(GER_CODS03 IS NOT NULL, CONCAT(GER_CODS03, "<<csq>>"), ""),    ';
  strSQL := strSQL + '        IF(GER_CODS04 IS NOT NULL, CONCAT(GER_CODS04, "<<csq>>"), ""),    ';
  strSQL := strSQL + '        IF(GER_CODS05 IS NOT NULL, CONCAT(GER_CODS05, "<<csq>>"), ""),    ';
  strSQL := strSQL + '        IF(GER_CODS06 IS NOT NULL, CONCAT(GER_CODS06, "<<csq>>"), ""),    ';
  strSQL := strSQL + '        IF(GER_CODS07 IS NOT NULL, CONCAT(GER_CODS07, "<<csq>>"), ""),    ';
  strSQL := strSQL + '        IF(GER_CODS08 IS NOT NULL, CONCAT(GER_CODS08, "<<csq>>"), ""),    ';
  strSQL := strSQL + '        IF(GER_CODS09 IS NOT NULL, CONCAT(GER_CODS09, "<<csq>>"), ""),    ';
  strSQL := strSQL + '        IF(GER_CODS10 IS NOT NULL, CONCAT(GER_CODS10, "<<csq>>"), ""),    ';
  strSQL := strSQL + '        IF(GER_CODS11 IS NOT NULL, CONCAT(GER_CODS11, "<<csq>>"), ""),    ';
  strSQL := strSQL + '        IF(GER_CODS12 IS NOT NULL, CONCAT(GER_CODS12, "<<csq>>"), ""),    ';
  strSQL := strSQL + '        IF(GER_CODS13 IS NOT NULL, CONCAT(GER_CODS13, "<<csq>>"), ""),    ';
  strSQL := strSQL + '        IF(GER_CODS14 IS NOT NULL, CONCAT(GER_CODS14, "<<csq>>"), ""),    ';
  strSQL := strSQL + '        IF(GER_CODS15 IS NOT NULL, CONCAT(GER_CODS15, "<<csq>>"), ""),    ';
  strSQL := strSQL + '        IF(GER_CODS16 IS NOT NULL, CONCAT(GER_CODS16, "<<csq>>"), ""),    ';
  strSQL := strSQL + '        IF(GER_CODS17 IS NOT NULL, CONCAT(GER_CODS17, "<<csq>>"), ""),    ';
  strSQL := strSQL + '        IF(GER_CODS18 IS NOT NULL, CONCAT(GER_CODS18, "<<csq>>"), ""),    ';
  strSQL := strSQL + '        IF(GER_CODS19 IS NOT NULL, CONCAT(GER_CODS19, "<<csq>>"), ""),    ';
  strSQL := strSQL + '        IF(GER_CODS20 IS NOT NULL, CONCAT(GER_CODS20, "<<csq>>"), ""),    ';
  strSQL := strSQL + '        IF(GER_CODS21 IS NOT NULL, CONCAT(GER_CODS21, "<<csq>>"), ""),    ';
  strSQL := strSQL + '        IF(GER_CODS22 IS NOT NULL, CONCAT(GER_CODS22, "<<csq>>"), ""),    ';
  strSQL := strSQL + '        IF(GER_CODS23 IS NOT NULL, CONCAT(GER_CODS23, "<<csq>>"), ""),    ';
  strSQL := strSQL + '        IF(GER_CODS24 IS NOT NULL, CONCAT(GER_CODS24, "<<csq>>"), ""),    ';
  strSQL := strSQL + '        IF(GER_CODS25 IS NOT NULL, CONCAT(GER_CODS25, "<<csq>>"), ""),    ';
  strSQL := strSQL + '        IF(GER_CODS26 IS NOT NULL, CONCAT(GER_CODS26, "<<csq>>"), ""),    ';
  strSQL := strSQL + '        IF(GER_CODS27 IS NOT NULL, CONCAT(GER_CODS27, "<<csq>>"), ""),    ';
  strSQL := strSQL + '        IF(GER_CODS28 IS NOT NULL, CONCAT(GER_CODS28, "<<csq>>"), ""),    ';
  strSQL := strSQL + '        IF(GER_CODS29 IS NOT NULL, CONCAT(GER_CODS29, "<<csq>>"), ""),    ';
  strSQL := strSQL + '        IF(GER_CODS30 IS NOT NULL, CONCAT(GER_CODS30, "<<csq>>"), "")     ';
  strSQL := strSQL + '        ) AS CODSER,                                                      ';

  strSQL := strSQL + '        CONCAT(                                                           ';
  strSQL := strSQL + '        IF(GER_DESS01 <> "", CONCAT(GER_DESS01, "<<csq>>"), ""),          ';
  strSQL := strSQL + '        IF(GER_DESS02 <> "", CONCAT(GER_DESS02, "<<csq>>"), ""),          ';
  strSQL := strSQL + '        IF(GER_DESS03 <> "", CONCAT(GER_DESS03, "<<csq>>"), ""),          ';
  strSQL := strSQL + '        IF(GER_DESS04 <> "", CONCAT(GER_DESS04, "<<csq>>"), ""),          ';
  strSQL := strSQL + '        IF(GER_DESS05 <> "", CONCAT(GER_DESS05, "<<csq>>"), ""),          ';
  strSQL := strSQL + '        IF(GER_DESS06 <> "", CONCAT(GER_DESS06, "<<csq>>"), ""),          ';
  strSQL := strSQL + '        IF(GER_DESS07 <> "", CONCAT(GER_DESS07, "<<csq>>"), ""),          ';
  strSQL := strSQL + '        IF(GER_DESS08 <> "", CONCAT(GER_DESS08, "<<csq>>"), ""),          ';
  strSQL := strSQL + '        IF(GER_DESS09 <> "", CONCAT(GER_DESS09, "<<csq>>"), ""),          ';
  strSQL := strSQL + '        IF(GER_DESS10 <> "", CONCAT(GER_DESS10, "<<csq>>"), ""),          ';
  strSQL := strSQL + '        IF(GER_DESS11 <> "", CONCAT(GER_DESS11, "<<csq>>"), ""),          ';
  strSQL := strSQL + '        IF(GER_DESS12 <> "", CONCAT(GER_DESS12, "<<csq>>"), ""),          ';
  strSQL := strSQL + '        IF(GER_DESS13 <> "", CONCAT(GER_DESS13, "<<csq>>"), ""),          ';
  strSQL := strSQL + '        IF(GER_DESS14 <> "", CONCAT(GER_DESS14, "<<csq>>"), ""),          ';
  strSQL := strSQL + '        IF(GER_DESS15 <> "", CONCAT(GER_DESS15, "<<csq>>"), ""),          ';
  strSQL := strSQL + '        IF(GER_DESS16 <> "", CONCAT(GER_DESS16, "<<csq>>"), ""),          ';
  strSQL := strSQL + '        IF(GER_DESS17 <> "", CONCAT(GER_DESS17, "<<csq>>"), ""),          ';
  strSQL := strSQL + '        IF(GER_DESS18 <> "", CONCAT(GER_DESS18, "<<csq>>"), ""),          ';
  strSQL := strSQL + '        IF(GER_DESS19 <> "", CONCAT(GER_DESS19, "<<csq>>"), ""),          ';
  strSQL := strSQL + '        IF(GER_DESS20 <> "", CONCAT(GER_DESS20, "<<csq>>"), ""),          ';
  strSQL := strSQL + '        IF(GER_DESS21 <> "", CONCAT(GER_DESS21, "<<csq>>"), ""),          ';
  strSQL := strSQL + '        IF(GER_DESS22 <> "", CONCAT(GER_DESS22, "<<csq>>"), ""),          ';
  strSQL := strSQL + '        IF(GER_DESS23 <> "", CONCAT(GER_DESS23, "<<csq>>"), ""),          ';
  strSQL := strSQL + '        IF(GER_DESS24 <> "", CONCAT(GER_DESS24, "<<csq>>"), ""),          ';
  strSQL := strSQL + '        IF(GER_DESS25 <> "", CONCAT(GER_DESS25, "<<csq>>"), ""),          ';
  strSQL := strSQL + '        IF(GER_DESS26 <> "", CONCAT(GER_DESS26, "<<csq>>"), ""),          ';
  strSQL := strSQL + '        IF(GER_DESS27 <> "", CONCAT(GER_DESS27, "<<csq>>"), ""),          ';
  strSQL := strSQL + '        IF(GER_DESS28 <> "", CONCAT(GER_DESS28, "<<csq>>"), ""),          ';
  strSQL := strSQL + '        IF(GER_DESS29 <> "", CONCAT(GER_DESS29, "<<csq>>"), ""),          ';
  strSQL := strSQL + '        IF(GER_DESS30 <> "", CONCAT(GER_DESS30, "<<csq>>"), "")           ';
  strSQL := strSQL + '        ) AS DESSER,                                                      ';

  strSQL := strSQL + '        CONCAT(                                                           ';
  strSQL := strSQL + '        IF(GER_VALS01 > 0, CONCAT(FORMAT(GER_VALS01,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(GER_VALS02 > 0, CONCAT(FORMAT(GER_VALS02,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(GER_VALS03 > 0, CONCAT(FORMAT(GER_VALS03,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(GER_VALS04 > 0, CONCAT(FORMAT(GER_VALS04,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(GER_VALS05 > 0, CONCAT(FORMAT(GER_VALS05,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(GER_VALS06 > 0, CONCAT(FORMAT(GER_VALS06,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(GER_VALS07 > 0, CONCAT(FORMAT(GER_VALS07,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(GER_VALS08 > 0, CONCAT(FORMAT(GER_VALS08,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(GER_VALS09 > 0, CONCAT(FORMAT(GER_VALS09,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(GER_VALS10 > 0, CONCAT(FORMAT(GER_VALS10,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(GER_VALS11 > 0, CONCAT(FORMAT(GER_VALS11,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(GER_VALS12 > 0, CONCAT(FORMAT(GER_VALS12,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(GER_VALS13 > 0, CONCAT(FORMAT(GER_VALS13,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(GER_VALS14 > 0, CONCAT(FORMAT(GER_VALS14,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(GER_VALS15 > 0, CONCAT(FORMAT(GER_VALS15,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(GER_VALS16 > 0, CONCAT(FORMAT(GER_VALS16,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(GER_VALS17 > 0, CONCAT(FORMAT(GER_VALS17,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(GER_VALS18 > 0, CONCAT(FORMAT(GER_VALS18,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(GER_VALS19 > 0, CONCAT(FORMAT(GER_VALS19,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(GER_VALS20 > 0, CONCAT(FORMAT(GER_VALS20,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(GER_VALS21 > 0, CONCAT(FORMAT(GER_VALS21,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(GER_VALS22 > 0, CONCAT(FORMAT(GER_VALS22,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(GER_VALS23 > 0, CONCAT(FORMAT(GER_VALS23,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(GER_VALS24 > 0, CONCAT(FORMAT(GER_VALS24,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(GER_VALS25 > 0, CONCAT(FORMAT(GER_VALS25,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(GER_VALS26 > 0, CONCAT(FORMAT(GER_VALS26,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(GER_VALS27 > 0, CONCAT(FORMAT(GER_VALS27,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(GER_VALS28 > 0, CONCAT(FORMAT(GER_VALS28,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(GER_VALS29 > 0, CONCAT(FORMAT(GER_VALS29,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(GER_VALS30 > 0, CONCAT(FORMAT(GER_VALS30,2), "<<csq>>"), "")   ';
  strSQL := strSQL + '        ) AS VALSER,                                                      ';

  strSQL := strSQL + '        CONCAT(                                                         ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS01,"") <> "", CONCAT(FORMAT(GER_QTDS01,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS02,"") <> "", CONCAT(FORMAT(GER_QTDS02,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS03,"") <> "", CONCAT(FORMAT(GER_QTDS03,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS04,"") <> "", CONCAT(FORMAT(GER_QTDS04,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS05,"") <> "", CONCAT(FORMAT(GER_QTDS05,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS06,"") <> "", CONCAT(FORMAT(GER_QTDS06,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS07,"") <> "", CONCAT(FORMAT(GER_QTDS07,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS08,"") <> "", CONCAT(FORMAT(GER_QTDS08,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS09,"") <> "", CONCAT(FORMAT(GER_QTDS09,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS10,"") <> "", CONCAT(FORMAT(GER_QTDS10,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS11,"") <> "", CONCAT(FORMAT(GER_QTDS11,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS12,"") <> "", CONCAT(FORMAT(GER_QTDS12,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS13,"") <> "", CONCAT(FORMAT(GER_QTDS13,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS14,"") <> "", CONCAT(FORMAT(GER_QTDS14,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS15,"") <> "", CONCAT(FORMAT(GER_QTDS15,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS16,"") <> "", CONCAT(FORMAT(GER_QTDS16,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS17,"") <> "", CONCAT(FORMAT(GER_QTDS17,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS18,"") <> "", CONCAT(FORMAT(GER_QTDS18,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS19,"") <> "", CONCAT(FORMAT(GER_QTDS19,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS20,"") <> "", CONCAT(FORMAT(GER_QTDS20,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS21,"") <> "", CONCAT(FORMAT(GER_QTDS21,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS22,"") <> "", CONCAT(FORMAT(GER_QTDS22,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS23,"") <> "", CONCAT(FORMAT(GER_QTDS23,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS24,"") <> "", CONCAT(FORMAT(GER_QTDS24,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS25,"") <> "", CONCAT(FORMAT(GER_QTDS25,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS26,"") <> "", CONCAT(FORMAT(GER_QTDS26,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS27,"") <> "", CONCAT(FORMAT(GER_QTDS27,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS28,"") <> "", CONCAT(FORMAT(GER_QTDS28,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS29,"") <> "", CONCAT(FORMAT(GER_QTDS29,2), "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS30,"") <> "", CONCAT(FORMAT(GER_QTDS30,2), "<<csq>>"), "")   ';
  strSQL := strSQL + '        ) AS QTDSER,                                                              ';

  strSQL := strSQL + '        CONCAT(                                                              ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS01,"") <> "", CONCAT(GER_PRIS01, "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS02,"") <> "", CONCAT(GER_PRIS02, "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS03,"") <> "", CONCAT(GER_PRIS03, "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS04,"") <> "", CONCAT(GER_PRIS04, "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS05,"") <> "", CONCAT(GER_PRIS05, "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS06,"") <> "", CONCAT(GER_PRIS06, "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS07,"") <> "", CONCAT(GER_PRIS07, "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS08,"") <> "", CONCAT(GER_PRIS08, "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS09,"") <> "", CONCAT(GER_PRIS09, "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS10,"") <> "", CONCAT(GER_PRIS10, "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS11,"") <> "", CONCAT(GER_PRIS11, "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS12,"") <> "", CONCAT(GER_PRIS12, "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS13,"") <> "", CONCAT(GER_PRIS13, "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS14,"") <> "", CONCAT(GER_PRIS14, "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS15,"") <> "", CONCAT(GER_PRIS15, "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS16,"") <> "", CONCAT(GER_PRIS16, "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS17,"") <> "", CONCAT(GER_PRIS17, "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS18,"") <> "", CONCAT(GER_PRIS18, "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS19,"") <> "", CONCAT(GER_PRIS19, "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS20,"") <> "", CONCAT(GER_PRIS20, "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS21,"") <> "", CONCAT(GER_PRIS21, "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS22,"") <> "", CONCAT(GER_PRIS22, "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS23,"") <> "", CONCAT(GER_PRIS23, "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS24,"") <> "", CONCAT(GER_PRIS24, "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS25,"") <> "", CONCAT(GER_PRIS25, "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS26,"") <> "", CONCAT(GER_PRIS26, "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS27,"") <> "", CONCAT(GER_PRIS27, "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS28,"") <> "", CONCAT(GER_PRIS28, "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS29,"") <> "", CONCAT(GER_PRIS29, "<<csq>>"), ""),  ';
  strSQL := strSQL + '        IF(IFNULL(GER_CODS30,"") <> "", CONCAT(GER_PRIS30, "<<csq>>"), "")   ';
  strSQL := strSQL + '        ) AS PRISMA, ';

  strSQL := strSQL + '  (GER_VALS01 + GER_VALS02 + GER_VALS03 + GER_VALS04 + GER_VALS05 + GER_VALS06 + GER_VALS07 + GER_VALS08 + GER_VALS09 + GER_VALS10 + ';
  strSQL := strSQL + '   GER_VALS11 + GER_VALS12 + GER_VALS13 + GER_VALS14 + GER_VALS15 + GER_VALS16 + GER_VALS17 + GER_VALS18 + GER_VALS19 + GER_VALS20 + ';
  strSQL := strSQL + '   GER_VALS21 + GER_VALS22 + GER_VALS23 + GER_VALS24 + GER_VALS25 + GER_VALS26 + GER_VALS27 + GER_VALS28 + GER_VALS29 + GER_VALS30 )AS TOTCSE, ';

  strSQL := strSQL + '        GER_CODEMP AS CEMSER,                                                     ';
  strSQL := strSQL + '        EMP_NOMFAN AS DEMSER,                                       ';
  strSQL := strSQL + '        GER_CODCLI AS CCLSER,                                                     ';
  strSQL := strSQL + '        CLI_NOMCLI AS NCLSER,                                                     ';
  strSQL := strSQL + '        AUX_PLAVEI AS PVESER,                                                     ';
  strSQL := strSQL + '        MOD_DESMOD AS DVESER,                                       ';
  strSQL := strSQL + '        GER_CODVEN AS CVDSER,                                                     ';
  strSQL := strSQL + '      V.OPE_NOMOPE AS NVDSER,                                                     ';
  strSQL := strSQL + '        GER_CODDIG AS CDISER,                                                     ';
  strSQL := strSQL + '      D.OPE_NOMOPE AS NDISER,                                       ';
  strSQL := strSQL + '        GER_DTAENT AS DTASER,                                                     ';
  strSQL := strSQL + '        GER_HORENT AS HORSER,                                                     ';
  strSQL := strSQL + '        GER_NUMDOC AS DOCSER,                                                     ';
  strSQL := strSQL + '        GER_ESPDOC AS ESPSER                                                      ';

  strSQL := strSQL + ' FROM MOVGER                                                            ';
  strSQL := strSQL + ' INNER JOIN SERMOV G ON G.GER_SEQGER = MOVGER.AUTOINCREM                ';
  strSQL := strSQL + ' INNER JOIN AUXMOV E ON E.AUX_SEQGER = MOVGER.AUTOINCREM                ';
  strSQL := strSQL + ' INNER JOIN CADEMP   ON   EMP_CODEMP = GER_CODEMP                       ';
  strSQL := strSQL + ' INNER JOIN CADCLI   ON   CLI_CODCLI = GER_CODCLI                       ';
  strSQL := strSQL + ' LEFT  JOIN CADVEI   ON   VEI_PLAVEI = AUX_PLAVEI                       ';
  strSQL := strSQL + ' LEFT  JOIN CADOPE V ON V.OPE_CODOPE = GER_CODVEN                       ';
  strSQL := strSQL + ' LEFT  JOIN CADOPE D ON D.OPE_CODOPE = GER_CODDIG                       ';
  strSQL := strSQL + ' LEFT  JOIN MODVEI   ON   MOD_CODMOD = VEI_CODMOD                       ';
  strSQL := strSQL + ' WHERE GER_CODEMP = :CODEMP                                             ';
  strSQL := strSQL + '   AND GER_NUMDOC = :NUMDOC                                             ';
  strSQL := strSQL + '   AND GER_ESPDOC = :ESPDOC                                             ';

  Result := strSQL;
end;

end.
