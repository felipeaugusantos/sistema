unit untModuloCadCbi;

interface

uses
  SysUtils, Classes, DB,   Uni, frxclass,
  StrUtils, untCadRec, MemDS, DBAccess;

type
  TfrmModuloCadCbi = class(TDataModule)
    qryCadCbi: TUniQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure pGravaCadRecGer(strNumDup,
                              strParcel,
                              strEspDoc,
                              strCodEmp,
                              strCodCli,
                              strCodBco,
                              strCodPor: String;
                              strCtrEme: String = '';
                              strNosNum: String = '';
                              strCartei: String = '';
                              dtaDtaBol: TDate  = 0;
                              strResEmi: String = '';
                              blnGlobalCob: Boolean = False;
                              fltPerMor: Double = 0;
                              strLinDig: String = '';
                              blnEnvPro: Boolean = False);

    procedure pGravaCadCbiGer(strNumDup,
                              strProtes,
                              strCgcCpf,
                              strParcel,
                              strEspDoc,
                              strCodEmp,
                              strCodCli,
                              strCodBco,
                              strPorcen,
                              strNosNum,
                              strCodPor: String;
                              dtaDtaCad,
                              dtaDtaVen: TDateTime;
                              curValDup,
                              curDesSuj: Currency;
                              strObsAg1,
                              strObsAg2,
                              strObsAg3: String;
                              strBcoCrr: String = '';
                              strNN_Crr: String = '';
                              intPrzPro: Integer = 0;
                              strCartei: String = '';
                              strCodCnd: String = '';
                              strStsSer: String = '';
                              dtaDtaIni: TDateTime = 0;
                              dtaDtaFin: TDateTime = 0;
                              strMotivEx: String = '';
                              blnGlobalCob: Boolean = False;
                              dtaDtaDev: TDateTime = 0;
                              strCodOco: String = '';
                              intTipRem: Integer = 0);

  end;

var
  frmModuloCadCbi: TfrmModuloCadCbi;

implementation

uses  untfuncoesSimples;

{$R *.dfm}

{***********************************}
{* APÓS A SELEÇÃO DE DUPLICATAS    *}
{* GRAVA OS DADOS NA TABELA CADREC *}
{********************************AF*}
procedure TfrmModuloCadCbi.pGravaCadRecGer(strNumDup,
                                           strParcel,
                                           strEspDoc,
                                           strCodEmp,
                                           strCodCli,
                                           strCodBco,
                                           strCodPor: String;
                                           strCtrEme: String = '';
                                           strNosNum: String = '';
                                           strCartei: String = '';
                                           dtaDtaBol: TDate  = 0;
                                           strResEmi: String = '';
                                           blnGlobalCob: Boolean = False;
                                           fltPerMor: Double = 0;
                                           strLinDig: String = '';
                                           blnEnvPro: Boolean = False);
  Var
    strSQL: String;
    qryCadRecGer: TUniQuery;
Begin

  Try

    qryCadRecGer := fCriaQuery(Self);

    If (Not blnEnvPro) Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'UPDATE  ';
      strSQL := strSQL + ' CADREC ';
      strSQL := strSQL + ' SET ';
      strSQL := strSQL + '  CTR_BCOBOL = :CODBCO, ';
      strSQL := strSQL + '  CTR_BCOENV = :CODBCO, ';
      strSQL := strSQL + '  CTR_DTAENV = ' + fCurrentDate + ', ';

      if not fEmptyStr(strCodPor) then
        strSQL := strSQL + '  CTR_CODPOR = :CODPOR, ';

      If blnGlobalCob Then
      begin
        strSQL := strSQL + '  CTR_DTAECO = CURRENT_DATE '; // DATA ENVIO COBRANCA
        strSQL := strSQL + ', CTR_CODOEC = :CODOEC  ';     // CODIGO DO OPERADOR DO ENVIO DA COBRANCA
      end
      else
        strSQL := strSQL + '  CTR_CTREME = :CTREME  ';

      If Not fEmptyStr(strCartei) and (Not blnGlobalCob) Then
        strSQL := strSQL + ',  CTR_CARTEI = :CARTEI  ';

      If Not fEmptyStr(strNosNum) Then
        strSQL := strSQL + ',  CTR_NOSNUM = :NOSNUM  ';

      if ((strCodBco = '070') and (strResEmi = 'B')) Or ((strCodBco = '748') And (strResEmi = 'B'))  then
        strSQL := strSQL + ',  CTR_CONREM = :CONREM  ';

      If (dtaDtaBol > 0) then
        strSQL := strSQL + ',  CTR_DTABOL = :DTABOL  ';

      If (fltPerMor > 0) Then
        strSQL := strSQL + ',  CTR_PERMOR = :PERMOR  ';

      If Not fEmptyStr(strLinDig) Then
        strSQL := strSQL + ',  CTR_LINDIG = :LINDIG  ';

      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
      strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
      strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND ';
      strSQL := strSQL + '  CTR_SEQBAI = 0 ';

      With qryCadRecGer Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        If Not fEmptyStr(strNosNum) Then
          ParamByName('NOSNUM').AsString := strNosNum;

        If (dtaDtaBol > 0) Then
          ParamByName('DTABOL').AsDateTime := dtaDtaBol;

        ParamByName('CODBCO').AsString := strCodBco;

        if not fEmptyStr(strCodPor) then
          ParamByName('CODPOR').AsString :=  fPadL(strCodPor,5,'0');

        If (Not fEmptyStr(strCtrEme)) and (not blnGlobalCob) Then
          ParamByName('CTREME').AsString := strCtrEme;

        if ((strCodBco = '070') and (strResEmi = 'B')) Or ((strCodBco = '748') And (strResEmi = 'B'))  then
          ParamByName('CONREM').AsString := fAtualizaProCod('CONREM', 'CTR_CONREM', 'CADREC');

        If Not fEmptyStr(strCartei) and (Not blnGlobalCob) Then
          ParamByName('CARTEI').AsString := strCartei;

        if blnGlobalCob Then
          ParamByName('CODOEC').AsString := strLoginUsuarioLogado;

        If (fltPerMor > 0) Then
          ParamByName('PERMOR').AsFloat := fltPerMor;

        If Not fEmptyStr(strLinDig) Then
          ParamByName('LINDIG').AsString := strLinDig;

        ParamByName('NUMDUP').AsString := strNumDup;
        ParamByName('PARCEL').AsString := strParcel;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('CODCLI').AsString := strCodCli;
        ExecSQL;
        Close;
      End;
    End;
  Finally
    FreeAndNil(qryCadRecGer);
  End;

End;

{*************************************}
{* APÓS A SELEÇÃO DE DUPLICATAS      *}
{* GRAVA OS DADOS NA TABELA CADCBI   *}
{*************************************}
{* A TABELA QUE VAI SER GRAVADA DEVE *}
{* ESTAR ABERTA                      *}
{**********************************AF*}
procedure TfrmModuloCadCbi.DataModuleCreate(Sender: TObject);
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

end;

procedure TfrmModuloCadCbi.pGravaCadCbiGer(strNumDup,
                                           strProtes,
                                           strCgcCpf,
                                           strParcel,
                                           strEspDoc,
                                           strCodEmp,
                                           strCodCli,
                                           strCodBco,
                                           strPorcen,
                                           strNosNum,
                                           strCodPor: String;
                                           dtaDtaCad,
                                           dtaDtaVen: TDateTime;
                                           curValDup,
                                           curDesSuj: Currency;
                                           strObsAg1,
                                           strObsAg2,
                                           strObsAg3: String;
                                           strBcoCrr: String = '';
                                           strNN_Crr: String = '';
                                           intPrzPro: Integer = 0;
                                           strCartei: String = '';
                                           strCodCnd: String = '';
                                           strStsSer: String = '';
                                           dtaDtaIni: TDateTime = 0;
                                           dtaDtaFin: TDateTime = 0;
                                           strMotivEx: String = '';
                                           blnGlobalCob: Boolean = False;
                                           dtaDtaDev: TDateTime = 0;
                                           strCodOco: String = '';
                                           intTipRem: Integer = 0);

  Var
    qryTabela: TUniQuery;
Begin
  qryTabela := fCriaQuery(Nil);
  qryTabela.SQL.Add('SELECT * FROM CADCBI WHERE FALSE ');
  qryTabela.Open;

  With qryTabela Do
  Begin
    Insert;
    FieldByName('CBI_NUMDUP').AsString   := strNumDup;
    FieldByName('CBI_PARCEL').AsString   := strParcel;
    FieldByName('CBI_ESPDOC').AsString   := strEspDoc;
    FieldByName('CBI_CODCLI').AsString   := strCodCli;
    FieldByName('CBI_CODEMP').AsString   := strCodEmp;
    FieldByName('CBI_EMPGER').AsString   := fGetEmpresaLogada();

    If strCodBco = 'SER' Then
      FieldByName('CBI_DTASER').AsDateTime := VS_Date;

    If strCodBco <> 'IEP' Then
      FieldByName('CBI_CODBCO').AsString   := strCodBco;

    FieldByName('CBI_PORCEN').AsString   := AnsiReplaceStr(strPorcen,'.',',');
    FieldByName('CBI_NOSNUM').AsString   := strNosNum;
    FieldByName('CBI_DTAVEN').AsDateTime := dtaDtaVen;
    FieldByName('CBI_DTACAD').AsDateTime := dtaDtaCad;
    FieldByName('CBI_VALDUP').AsCurrency := curValDup;
    FieldByName('CBI_DESSUJ').AsCurrency := curDesSuj;

    If blnGlobalCob Then
      FieldByName('CBI_CODOEC').AsString := strLoginUsuarioLogado;

    If Length(strCgcCpf) > 11 Then
      FieldByName('CBI_CGCCPF').AsString := '1'

    Else If Length(strCgcCpf) > 0 Then
      FieldByName('CBI_CGCCPF').AsString := '2'

    Else
      FieldByName('CBI_CGCCPF').AsString := '0';

    FieldByName('CBI_C_G_C_').AsString   := strCgcCpf;
    FieldByName('CBI_PROTES').AsString   := strProtes;

    FieldByName('CBI_OBSAG1').AsString   := strObsAg1;
    FieldByName('CBI_OBSAG2').AsString   := strObsAg2;
    FieldByName('CBI_OBSAG3').AsString   := strObsAg3;

    If Not fEmptyStr(strCodPor) Then
      FieldByName('CBI_CODPOR').AsString   := strCodPor;

    If Not fEmptyStr(strBcoCrr) Then
      FieldByName('CBI_BCOCRR').AsString := strBcoCrr;

    If Not fEmptyStr(strNN_Crr) Then
      FieldByName('CBI_NN_CRR').AsString := strNN_Crr;

    If Not fEmptyStr(strCodCnd) Then
      FieldByName('CBI_CODCND').AsString := strCodCnd;

    FieldByName('CBI_PRZPRO').AsInteger:= intPrzPro;

    If (Not blnGlobalCob) Then
      FieldByName('CBI_CARTEI').AsString := strCartei;

    If Not fEmptyStr(strStsSer) Then
      FieldByName('CBI_STSSER').AsString  := strStsSer;

    If dtaDtaIni <> 0 Then
      FieldByName('CBI_DTAINI').AsDateTime:= dtaDtaIni;

    If dtaDtaFin <> 0 Then
      FieldByName('CBI_DTAFIN').AsDateTime:= dtaDtaFin;

    If dtaDtaDev <> 0 Then
      FieldByName('CBI_DTADEV').AsDateTime:= dtaDtaDev;

    If Not fEmptyStr(strMotivEx) Then
      FieldByName('CBI_MOTSPC').AsString := strMotivEx;

    If Not fEmptyStr(strCodOco) Then
      FieldByName('CBI_CODOCO').AsString := strCodOco;

    FieldByName('CBI_TIPREM').AsInteger := intTipRem;

    Post;
  End;

  FreeAndNil(qryTabela);

End;

end.
