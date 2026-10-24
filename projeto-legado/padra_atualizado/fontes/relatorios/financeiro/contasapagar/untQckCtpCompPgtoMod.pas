unit untQckCtpCompPgtoMod;

interface

uses
  SysUtils, Classes, frxClass, frxDBSet, UniClientDataSet, DB, frxDMPExport,
  Uni, Forms;

type
  TfrmQckCtpCompPgtoMod = class(TForm)
    frxDataCtp: TfrxDBDataset;
    frxCtpCompPg_M: TfrxReport;
    frxCtpCompPg_J: TfrxReport;
    frxMatricial: TfrxDotMatrixExport;
    frxMod3Vias: TfrxReport;
    frxCtpDet: TfrxDBDataset;
    frxCtpChq: TfrxDBDataset;
    frxCtpCompPgSelecionadas_J: TfrxReport;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    function frxCtpCompPg_MUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxCtpCompPg_JUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxMod3ViasUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxCtpCompPgSelecionadas_JUserFunction(const MethodName: string;
      var Params: Variant): Variant;
  private
    { Private declarations }

    function fRemoveAcentos(strHistor: String): String;

    function fVerificaComponenteRelExiste(strComponente,
                                          strInformacao : String;
                                          blnVisible: Boolean = True) : Boolean;

  public
    { Public declarations }
    cdsGenCP : TUniClientDataSet;
    cdsGenDT : TUniClientDataSet;
    cdsGenCH : TUniClientDataSet;
    strTipoImpressao: string;
    intTipoCfg: Integer;
  end;

var
  frmQckCtpCompPgtoMod: TfrmQckCtpCompPgtoMod;

implementation

{$R *.dfm}

procedure TfrmQckCtpCompPgtoMod.DataModuleCreate(Sender: TObject);
  var
    intContador:integer;
begin
  {****************************************************}
  {*  DESABILITA OS BOT’ES SAVE, LOAD e EDIT DO FAST  *}
  {*11/05/2015**************************************RB*}
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin

    If (Self.Components[intContador] Is TfrxReport) Then
    Begin
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons :=
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons - [pbSave, pbLoad, pbEdit];
    End;
  End;

  frxMod3Vias.AddFunction('function fVerificaComponenteRelExiste(strComponente,strInformacao: String; blnVisible : Boolean = True): Boolean;');
  frxCtpCompPg_M.AddFunction('function fVerificaComponenteRelExiste(strComponente,strInformacao: String; blnVisible : Boolean = True): Boolean;');
  frxCtpCompPg_J.AddFunction('function fVerificaComponenteRelExiste(strComponente,strInformacao: String; blnVisible : Boolean = True): Boolean;');

  cdsGenCP := TUniClientDataSet.Create(Self);
  cdsGenDT := TUniClientDataSet.Create(Self);
  cdsGenCH := TUniClientDataSet.Create(Self);

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODFOR';
    DataType := ftString;
    Size := 8;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODPOR';
    DataType := ftString;
    Size := 8;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PARCEL';
    DataType := ftString;
    Size := 1;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODEMP';
    DataType := ftString;
    Size := 3;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'SERIE_';
    DataType := ftString;
    Size := 3;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NOMEMP';
    DataType := ftString;
    Size := 50;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NOMFOR';
    DataType := ftString;
    Size := 50;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NOMEVE';
    DataType := ftString;
    Size := 50;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NOMPOR';
    DataType := ftString;
    Size := 50;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESCUS';
    DataType := ftString;
    Size := 50;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESCRE';
    DataType := ftString;
    Size := 48;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DTACAD';
    DataType := ftDate;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DTADOC';
    DataType := ftDate;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CHAVE';
    DataType := ftString;
    Size := 30;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NUMDUP';
    DataType := ftString;
    Size := 20;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DTAVEN';
    DataType := ftDate;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VEIONF';
    DataType := ftString;
    Size := 5;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CENCUS';
    DataType := ftString;
    Size := 50;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VEIOBO';
    DataType := ftString;
    Size := 5;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'HIST01';
    DataType := ftMemo;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'HIST02';
    DataType := ftString;
    Size := 50;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DUPLIC';
    DataType := ftFloat;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VALTOT';
    DataType := ftFloat;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'JURSUJ';
    DataType := ftFloat;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MULSUJ';
    DataType := ftFloat;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESSUJ';
    DataType := ftFloat;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VENDOR';
    DataType := ftFloat;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'OUTENT';
    DataType := ftFloat;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NUMVIA';
    DataType := ftInteger;
  End;

  With cdsGenDT.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_CODFOR';
    DataType := ftString;
    Size := 8;
  End;

  With cdsGenDT.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_NUMDUP';
    DataType := ftString;
    Size := 12;
  End;

  With cdsGenDT.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_PARCEL';
    DataType := ftString;
    Size := 1;
  End;

  With cdsGenDT.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_EMPORI';
    DataType := ftString;
    Size := 3;
  End;

  With cdsGenDT.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_SERIE_';
    DataType := ftString;
    Size := 3;
  End;

  With cdsGenDT.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_CODCTA';
    DataType := ftString;
    Size := 7;
  End;

  With cdsGenDT.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTA_DESCTA';
    DataType := ftString;
    Size := 30;
  End;

  With cdsGenDT.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_CODEMP';
    DataType := ftString;
    Size := 3;
  End;

  With cdsGenDT.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_CODEVE';
    DataType := ftString;
    Size := 5;
  End;

  With cdsGenDT.FieldDefs.AddFieldDef Do
  Begin
    Name := 'EVE_DESEVE';
    DataType := ftString;
    Size := 40;
  End;

  With cdsGenDT.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CTP_FATCAL';
    DataType := ftFloat;
  End;

   With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CONTADEPOSITO';
    DataType := ftString;
    Size := 50
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CONTABANCO';
    DataType := ftString;
    Size := 90
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DEPOSITO';
    DataType := ftString;
    Size := 5;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CHEQUE';
    DataType := ftString;
    Size := 5;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do
  Begin
    Name := 'GUIDES';
    DataType := ftString;
    Size := 50;
  End;

  With cdsGenCP.FieldDefs.AddFieldDef Do //MF: 286456 - 06/06/2023
  Begin
    Name := 'REIMPR';
    DataType := ftString;
    Size := 15;
  End;

  With cdsGenCH.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CHQBCO';
    DataType := ftString;
    Size := 3;
  End;

  With cdsGenCH.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CHQAGE';
    DataType := ftString;
    Size := 5;
  End;

  With cdsGenCH.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CHQCOR';
    DataType := ftString;
    Size := 12;
  End;

  With cdsGenCH.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NUMCHQ';
    DataType := ftString;
    Size := 10;
  End;

  With cdsGenCH.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CHQCLI';
    DataType := ftString;
    Size := 8;
  End;

  With cdsGenCH.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CHQVEN';
    DataType := ftDate;
  End;

  cdsGenCP.CreateDataSet;
  cdsGenDT.CreateDataSet;
  cdsGenCH.CreateDataSet;

  cdsGenDT.IndexFieldNames := 'CTP_CODEMP;CTP_CODCTA';

  frxCtpCompPg_M.AddFunction('function fRemoveAcentos(strHistor: String): String');

end;

procedure TfrmQckCtpCompPgtoMod.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(cdsGenCP);
  FreeAndNil(cdsGenDT);
  FreeAndNil(cdsGenCH);
end;

function TfrmQckCtpCompPgtoMod.frxCtpCompPg_JUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If MethodName = 'FVERIFICACOMPONENTERELEXISTE' Then
    Result := fVerificaComponenteRelExiste(Params[0],Params[1],Params[2])
end;

function TfrmQckCtpCompPgtoMod.frxCtpCompPg_MUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If (SameText(MethodName, 'FREMOVEACENTOS')) Then
    Result := fRemoveAcentos(Trim(Params[0]));

  If MethodName = 'FVERIFICACOMPONENTERELEXISTE' Then
    Result := fVerificaComponenteRelExiste(Params[0],Params[1],Params[2]);
end;

function TfrmQckCtpCompPgtoMod.frxMod3ViasUserFunction(const MethodName: string;
  var Params: Variant): Variant;
begin
  If MethodName = 'FVERIFICACOMPONENTERELEXISTE' Then
    Result := fVerificaComponenteRelExiste(Params[0],Params[1],Params[2]);
end;

function TfrmQckCtpCompPgtoMod.frxCtpCompPgSelecionadas_JUserFunction(const MethodName: string;
  var Params: Variant): Variant;
begin
  If (SameText(MethodName, 'FREMOVEACENTOS')) Then
    Result := fRemoveAcentos(Trim(Params[0]));

  If MethodName = 'FVERIFICACOMPONENTERELEXISTE' Then
    Result := fVerificaComponenteRelExiste(Params[0],Params[1],Params[2]);
end;

function TfrmQckCtpCompPgtoMod.fRemoveAcentos(strHistor: String): String;
	Const
		ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸¿¬ ‘€√’¡…Õ”⁄«‹"¥';
		SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU  ';
	Var
		x : Integer;
Begin
	For x := 1 to Length(strHistor) do
		If Pos(strHistor[x],ComAcento)<>0 Then
			strHistor[x] := SemAcento[Pos(strHistor[x],ComAcento)];
  Result := strHistor;
end;

function TfrmQckCtpCompPgtoMod.fVerificaComponenteRelExiste(strComponente,
  strInformacao: String; blnVisible: Boolean): Boolean;
begin
  Result := False;

  If intTipoCfg <> 3 Then
  Begin
    If strTipoImpressao = 'J' Then
    Begin
      If Assigned(frxCtpCompPg_J.FindObject(strComponente)) Then
      Begin
        If strInformacao = 'VISIBLE' Then
        Begin
          frxCtpCompPg_J.FindObject(strComponente).Visible := blnVisible;
        End
        Else
          TfrxMemoView(frxCtpCompPg_J.FindObject(strComponente)).Memo.Text := strInformacao;

        Result := True;
      End
    End
    Else
    Begin
      If Assigned(frxCtpCompPg_M.FindObject(strComponente)) Then
      Begin
        If strInformacao = 'VISIBLE' Then
        Begin
          frxCtpCompPg_M.FindObject(strComponente).Visible := blnVisible;
        End
        Else
          TfrxMemoView(frxCtpCompPg_M.FindObject(strComponente)).Memo.Text := strInformacao;

        Result := True;
      End
    End;
  End
  Else
  Begin
    If Assigned(frxMod3Vias.FindObject(strComponente)) Then
    Begin
      If strInformacao = 'VISIBLE' Then
      Begin
        frxMod3Vias.FindObject(strComponente).Visible := blnVisible;
      End
      Else
        TfrxMemoView(frxMod3Vias.FindObject(strComponente)).Memo.Text := strInformacao;

      Result := True;
    End;
  End;
end;

end.
