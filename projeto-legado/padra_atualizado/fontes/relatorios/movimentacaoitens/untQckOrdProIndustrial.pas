unit untQckOrdProIndustrial;

interface

uses
  SysUtils, Classes, frxClass, frxDBSet, Uni, Data.DB, Forms, frxDMPExport;

type
  TfrmQckOrdProIndustrial = class(TForm)
    frxReportJ_10: TfrxReport;
    frxIteFor: TfrxDBDataset;
    frxIteAca: TfrxDBDataset;
    frxCabec: TfrxDBDataset;
    frxDispersao: TfrxDBDataset;
    frxReportJ_2: TfrxReport;
    frxGeiQua: TfrxDBDataset;
    frxReportJ_3: TfrxReport;
    frxObserv: TfrxDBDataset;
    frxReportJ_5: TfrxReport;
    frxReportJ_6: TfrxReport;
    frxAnalise: TfrxDBDataset;
    frxEPI: TfrxDBDataset;
    frxGerCom: TfrxDBDataset;
    frxReportJ_7: TfrxReport;
    frxCorrecao: TfrxDBDataset;
    frxReportJ: TfrxReport;
    frxReportJ_11: TfrxReport;
    frxReportJ_13: TfrxReport;
    frxReportJ_12: TfrxReport;
    frxReportJ_14: TfrxReport;
    frxReportJ_15: TfrxReport;
    frxReportJ_16: TfrxReport;
    frxReportJ_8: TfrxReport;
    frxGerExt: TfrxDBDataset;
    frxReportJ_17: TfrxReport;
    frxReportJ_18: TfrxReport;
    frxReportJ_9: TfrxReport;
    frxReportJ_19: TfrxReport;
    frxReportJ_20: TfrxReport;
    frxReportJ_21: TfrxReport;
    frxReportJ_22: TfrxReport;
    frxReportJ_23: TfrxReport;
    frxReportJ_24: TfrxReport;
    frxReportJ_25: TfrxReport;
    frxReportJ_26: TfrxReport;
    frxReportJ_27: TfrxReport;
    frxReportJ_28: TfrxReport;
    frxReportJ_29: TfrxReport;
    frxReportJ_30: TfrxReport;
    frxReportJ_31: TfrxReport;
    frxFases: TfrxDBDataset;
    frxDotMatrixExport1: TfrxDotMatrixExport;
    frxReportM_32: TfrxReport;
    frxReportConferenciaM: TfrxReport;
    frxReportEnvaseM: TfrxReport;
    frxReportJ_33: TfrxReport;
    frxReportJ_34: TfrxReport;
    frxReportJ_4: TfrxReport;
    frxReportJ_37: TfrxReport;
    function frxReportJ_2UserFunction(const MethodName: string;
      var Params: Variant): Variant;
    procedure DataModuleCreate(Sender: TObject);
    function frxReportJ_4UserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxReportJ_6UserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxReportJ_10UserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxReportJ_50UserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxReportJ_12UserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxReportJ_13UserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxReportJ_8UserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxReportJ_17UserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxReportJ_20UserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxReportJ_19UserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxReportJ_21UserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxReportJ_22UserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxReportJ_23UserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxReportJ_24UserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxReportJ_26UserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxReportJ_27UserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxReportJ_28UserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxReportJ_29UserFunction(const MethodName: string;
      var Params: Variant): Variant;
  private
    Function fRetClientesPedidosOPI(strAutIncOrdGer, strOpcCliPed : String; blnFullResult : Boolean): String;
    Function fAbreComposicao(strSeqDet: String) : Boolean;
    Function fBuscaLocFisica(strSeqDet, strCodIte: String): String;

    var blnBuscaLocFisica : Boolean;

  public
    { Public declarations }
  end;

var
  frmQckOrdProIndustrial: TfrmQckOrdProIndustrial;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmQckOrdProIndustrial.DataModuleCreate(Sender: TObject);
  var
    intContador:integer;
begin
  {****************************************************}
  {*  DESABILITA OS BOTÕES SAVE, LOAD e EDIT DO FAST  *}
  {*11/05/2015**************************************RB*}
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin

    If (Self.Components[intContador] Is TfrxReport) Then
    Begin
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons :=
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons - [pbSave, pbLoad, pbEdit];
    End;
  End;

  frxReportJ_4.AddFunction('function fRetClientesPedidosOPI(strAutIncOrdGer, strOpcCliPed: String; blnFullResult: Boolean): String;');
  frxReportJ_5.AddFunction('function fRetClientesPedidosOPI(strAutIncOrdGer, strOpcCliPed: String; blnFullResult: Boolean): String;');
  frxReportJ_9.AddFunction('function fRetClientesPedidosOPI(strAutIncOrdGer, strOpcCliPed: String; blnFullResult: Boolean): String;');
  frxReportJ_11.AddFunction('function fRetClientesPedidosOPI(strAutIncOrdGer, strOpcCliPed: String; blnFullResult: Boolean): String;');
  frxReportJ_13.AddFunction('function fRetClientesPedidosOPI(strAutIncOrdGer, strOpcCliPed: String; blnFullResult: Boolean): String;');
  frxReportJ_31.AddFunction('function fRetClientesPedidosOPI(strAutIncOrdGer, strOpcCliPed: String; blnFullResult: Boolean): String;');
end;

function TfrmQckOrdProIndustrial.fAbreComposicao(strSeqDet: String): Boolean;
begin
  Try
    Result := True;
    frxGerCom.DataSet.Close;
    TUniQuery(frxGerCom.DataSet).ParamByName('SEQDET').AsString := strSeqDet;
    frxGerCom.DataSet.Open;

    if blnBuscaLocFisica then
      frxReportJ_21.Script.Variables['LOCAFI']     := fBuscaLocFisica(strSeqDet,TUniQuery(frxGerCom.DataSet).FieldByName('CODITE').AsString);

  Except
    Result := False;
  End;
end;

function TfrmQckOrdProIndustrial.fBuscaLocFisica(strSeqDet, strCodIte: String): String;
Var
   qryConsulta : TUniQuery;
begin
  Try
    qryConsulta := fCriaQuery(Self);
    With qryConsulta, SQL Do
    Begin
      Close;
      Clear;
      Add('SELECT DISTINCT LOT_LOCFIS                                   ');
      Add('FROM ORDDET                                                  ');
      Add('INNER JOIN ORDCOM   ON ORDCOM.ODC_SEQDET = ORDDET.AUTOINCREM ');
      Add('INNER JOIN ORDGER O on O.AUTOINCREM =  ORDDET.ORD_SEQGER     ');
      Add('INNER JOIN EXTGOR E ON E.FGO_ORDIND = O.AUTOINCREM           ');
      Add('INNER JOIN FATGOR G ON G.AUTOINCREM = E.FGO_SEQFGO           ');
      Add('INNER JOIN FATDOR D ON D.FDO_SEQGER = G.AUTOINCREM           ');
      Add('AND FDO_CODITE = ODC_CODITE                                  ');
      Add('INNER JOIN CADLOT L ON L.LOT_CODITE = FDO_CODITE             ');
      Add('AND L.LOT_CODEMP = FDO_CODEMP                                ');
      Add('AND L.LOT_NUMLOT = FDO_NUMLOT                                ');
      Add('WHERE ODC_SEQDET = :SEQDET                                   ');
      Add('AND ODC_CODITE = :CODITE                                     ');
    //Add('AND ORD_QTDENV <> 0                                          ');

      ParamByName('SEQDET').AsString := strSeqDet;
      ParamByName('CODITE').AsString := strCodIte;
      Open;

      result := FieldByName('LOT_LOCFIS').AsString;

      {| Req: 276320 - CASO RECLAMEM QUE NÃO CARREGOU DE  |
       |    ONDE ENVASOU DEVE TER QUE CARREGAR DA MOVDET  |
       ----------------------------------------------------
       SELECT GROUP_CONCAT(LOT_LOCFIS) FROM ORDCOM
        INNER JOIN ORDDET ON ORDDET.AUTOINCREM = ODC_SEQDET
        INNER JOIN ORDMAT ON ODM_SEQGER = ORD_SEQGER
        INNER JOIN MOVDET ON MOVDET.AUTOINCREM = ODM_SEQDET
                                AND ODM_ITESUB = DET_CODITE
        INNER JOIN CADLOT L ON L.LOT_CODITE = DET_CODITE
                           AND L.LOT_CODEMP = DET_CODEMP
                           AND L.LOT_NUMLOT = DET_NUMLOT
      WHERE ODC_SEQDET IN ('01100000000005659001')
        AND DET_CODITE IN ('0124917');}
    end;


  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function TfrmQckOrdProIndustrial.fRetClientesPedidosOPI(strAutIncOrdGer, strOpcCliPed: String; blnFullResult: Boolean): String;
  Var
    qryConsulta : TUniQuery;
begin
  Try
    qryConsulta := fCriaQuery(Self);
    With qryConsulta, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT FDO_NUMDOC, FDO_ESPDOC,               ');
      Add('        FDO_CODEMP, FDO_CODCLI                ');
      Add(' FROM FATDOR                                  ');
      Add(' INNER JOIN EXTDOR ON FDO_SEQFDO = AUTOINCREM ');
      Add(' WHERE FDO_SEQOPI = :SEQOPI                   ');

      ParamByName('SEQOPI').AsString := strAutIncOrdGer;
      Open;

      If IsEmpty Then
        Exit;

      Result := '';
      First;
      If blnFullResult Then
      Begin
        While not Eof Do
        Begin
          If strOpcCliPed = 'C' Then
            Result := Result + FieldByName('FDO_CODCLI').AsString
          Else
            Result := Result + FieldByName('FDO_NUMDOC').AsString + '-' +
                               FieldByName('FDO_ESPDOC').AsString + '-' +
                               FieldByName('FDO_CODEMP').AsString ;

          Next;

          If Not Eof Then
            Result := Result + ', ';

        End;

      End
      Else
      Begin
        If strOpcCliPed = 'C' Then
          Result := Result + FieldByName('FDO_CODCLI').AsString + ' - ' +
                             fRetNomCliente(FieldByName('FDO_CODCLI').AsString)
        Else
          Result := Result + FieldByName('FDO_NUMDOC').AsString + '-' +
                             FieldByName('FDO_ESPDOC').AsString + '-' +
                             FieldByName('FDO_CODEMP').AsString ;


      End;

      Close;
    End;

  Finally
    FreeAndNil(qryConsulta);
  End;

end;

function TfrmQckOrdProIndustrial.frxReportJ_50UserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  if SameText(MethodName, 'fRetLocFisica') then
    Result := fRetLocFisica(Params[0]);
end;

function TfrmQckOrdProIndustrial.frxReportJ_26UserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If SameText(UpperCase(MethodName), UpperCase('fAbreComposicao')) Then
    Result := fAbreComposicao(Params[0]);
end;

function TfrmQckOrdProIndustrial.frxReportJ_27UserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If SameText(UpperCase(MethodName), UpperCase('fAbreComposicao')) Then
    Result := fAbreComposicao(Params[0]);
end;

function TfrmQckOrdProIndustrial.frxReportJ_28UserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If SameText(UpperCase(MethodName), UpperCase('fAbreComposicao')) Then
  begin
    Result := fAbreComposicao(Params[0]);
    blnBuscaLocFisica := True;
  end
  Else if SameText(MethodName, 'fRetLocFisica') then
    Result := fRetLocFisica(Params[0]);
end;

function TfrmQckOrdProIndustrial.frxReportJ_29UserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If SameText(UpperCase(MethodName), UpperCase('fAbreComposicao')) Then
    Result := fAbreComposicao(Params[0]);
end;

function TfrmQckOrdProIndustrial.frxReportJ_10UserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If SameText(UpperCase(MethodName), UpperCase('fAbreComposicao')) Then
    Result := fAbreComposicao(Params[0]);
end;

function TfrmQckOrdProIndustrial.frxReportJ_12UserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  if SameText(MethodName, 'fRetLocFisica') then
    Result := fRetLocFisica(Params[0]);
end;

function TfrmQckOrdProIndustrial.frxReportJ_13UserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If SameText(UpperCase(MethodName), UpperCase('fRetClientesPedidosOPI')) Then
    Result := fRetClientesPedidosOPI(Params[0],Params[1],Params[2])
  Else if SameText(MethodName, 'fRetLocFisica') then
    Result := fRetLocFisica(Params[0]);
end;

function TfrmQckOrdProIndustrial.frxReportJ_17UserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  if SameText(MethodName, 'fRetLocFisica') then
    Result := fRetLocFisica(Params[0]);
end;

function TfrmQckOrdProIndustrial.frxReportJ_19UserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If SameText(UpperCase(MethodName), UpperCase('fAbreComposicao')) Then
    Result := fAbreComposicao(Params[0]);
end;

function TfrmQckOrdProIndustrial.frxReportJ_20UserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If SameText(UpperCase(MethodName), UpperCase('fAbreComposicao')) Then
    Result := fAbreComposicao(Params[0])
  Else if SameText(MethodName, 'fRetLocFisica') then
    Result := fRetLocFisica(Params[0]);
 end;

function TfrmQckOrdProIndustrial.frxReportJ_21UserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If SameText(UpperCase(MethodName), UpperCase('fAbreComposicao')) Then
  begin
    Result := fAbreComposicao(Params[0]);
    blnBuscaLocFisica := True;
  end
  Else if SameText(MethodName, 'fRetLocFisica') then
    Result := fRetLocFisica(Params[0]);
end;

function TfrmQckOrdProIndustrial.frxReportJ_22UserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If SameText(UpperCase(MethodName), UpperCase('fAbreComposicao')) Then
    Result := fAbreComposicao(Params[0]);
end;

function TfrmQckOrdProIndustrial.frxReportJ_23UserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If SameText(UpperCase(MethodName), UpperCase('fAbreComposicao')) Then
    Result := fAbreComposicao(Params[0]);
end;

function TfrmQckOrdProIndustrial.frxReportJ_24UserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If SameText(UpperCase(MethodName), UpperCase('fAbreComposicao')) Then
    Result := fAbreComposicao(Params[0]);
end;

function TfrmQckOrdProIndustrial.frxReportJ_2UserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  if SameText(MethodName, 'fRetLocFisica') then
    Result := fRetLocFisica(Params[0]);
end;

function TfrmQckOrdProIndustrial.frxReportJ_4UserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If SameText(UpperCase(MethodName), UpperCase('fRetClientesPedidosOPI')) Then
    Result := fRetClientesPedidosOPI(Params[0],Params[1],Params[2])
  Else if SameText(MethodName, 'fRetLocFisica') then
    Result := fRetLocFisica(Params[0]);
end;

function TfrmQckOrdProIndustrial.frxReportJ_6UserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If SameText(UpperCase(MethodName), UpperCase('fAbreComposicao')) Then
    Result := fAbreComposicao(Params[0]);

end;

function TfrmQckOrdProIndustrial.frxReportJ_8UserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If SameText(UpperCase(MethodName), UpperCase('fAbreComposicao')) Then
    Result := fAbreComposicao(Params[0]);
end;

end.
