unit untModuloFatImp
;

interface

uses
  SysUtils, Classes, frxClass, frxDBSet, DB, frxDMPExport,Forms;

type
  TfrmModuloFatImp = class(TForm)
    frxDocSep80: TfrxReport;
    frxItens: TfrxDBDataset;
    frxFatGor: TfrxDBDataset;
    frxMovGer: TfrxDBDataset;
    frxCadEmp: TfrxDBDataset;
    frxCadSep: TfrxDBDataset;
    dtsCadSep: TDataSource;
    frxDocSep40: TfrxReport;
    frxMatricial: TfrxDotMatrixExport;
    frxDocSep40Item: TfrxReport;
    frxDBSepItem: TfrxDBDataset;
    frxDocSep80_Mod4: TfrxReport;
    frxDocSepMeiaFolha80: TfrxReport;
    frxDocSep40Item_J: TfrxReport;
    procedure DataModuleCreate(Sender: TObject);
    function frxDocSep80_Mod4UserFunction(const MethodName: string; var Params: Variant): Variant;
    function frxDocSep80UserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxDocSep40UserFunction(const MethodName: string;
      var Params: Variant): Variant;
  private
    function fFormataFoneInterna(strTelefo: String): String;
    function fRetLocFisica(strLocFis, strLocSup: String): String;
  public
    frxDocSepItem: TfrxReport;
    { Public declarations }
  end;

var
  frmModuloFatImp: TfrmModuloFatImp;

implementation

uses untFuncoesSimples,untFuncoesGenerica;

{$R *.dfm}

procedure TfrmModuloFatImp.DataModuleCreate(Sender: TObject);
  Var
    strNumDec: String;
    blnExpSep: Boolean;
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

  strNumDec := IntToStr(fCfgSis('DECQTD', varInteger));
  blnExpSep := (fCfgSis('EXPSEP', varString) = 'S');

  With frxDocSep80 Do
  Begin
    TfrxMemoView(FindObject('mmoQtdIte')).DisplayFormat.FormatStr := '%2.' + strNumDec + 'f';
    TfrxMemoView(FindObject('rdbQtdTot')).DisplayFormat.FormatStr := '%2.' + strNumDec + 'f';
    TfrxMemoView(FindObject('qrlConPag')).Visible := (fCfgSis('USACND', varBoolean));
    TfrxMemoView(FindObject('qrdConPag')).Visible := (fCfgSis('USACND', varBoolean));
    TfrxMemoView(FindObject('mmoMenExp')).Visible := blnExpSep;
    TfrxMemoView(FindObject('mmoMenSa2')).Visible := blnExpSep;
    If (Not blnExpSep) Then
      TfrxPageFooter(FindObject('PageFooterPadrao')).Height := TfrxPageFooter(FindObject('PageFooterPadrao')).Height - TfrxMemoView(FindObject('mmoMenSa2')).Height;
  End;

  With frxDocSepMeiaFolha80 Do
  Begin
    TfrxMemoView(FindObject('mmoQtdIte')).DisplayFormat.FormatStr := '%2.' + strNumDec + 'f';
    TfrxMemoView(FindObject('qrlConPag')).Visible := (fCfgSis('USACND', varBoolean));
    TfrxMemoView(FindObject('qrdConPag')).Visible := (fCfgSis('USACND', varBoolean));
    TfrxMemoView(FindObject('mmoMenExp')).Visible := blnExpSep;
    TfrxMemoView(FindObject('mmoMenSa2')).Visible := blnExpSep;
    If (Not blnExpSep) Then
      TfrxPageFooter(FindObject('PageFooterPadrao')).Height := TfrxPageFooter(FindObject('PageFooterPadrao')).Height - TfrxMemoView(FindObject('mmoMenSa2')).Height;
  End;

  With frxDocSep40 Do
  Begin
    TfrxMemoView(FindObject('dbQTDEITEM1')).DisplayFormat.FormatStr := '%2.' + strNumDec + 'f';
    TfrxMemoView(FindObject('rdbQtdTot')).DisplayFormat.FormatStr := '%2.' + strNumDec + 'f';
    TfrxMemoView(FindObject('rllNumGui')).Visible := fCfgSis('USAGUI', varBoolean);
  End;

  frxDocSep80_Mod4.AddFunction('function fRetVal(strCampo: String): String;');
  frxDocSep80.AddFunction('function fFormataFone(strTelefo: String): String;');
  frxDocSepMeiaFolha80.AddFunction('function fFormataFone(strTelefo: String): String;');

  frxDocSep40.AddFunction('function fRetLocFisica(strLocFis, strLocSup: String): String');
end;

function TfrmModuloFatImp.fFormataFoneInterna(strTelefo: String): String;
begin
  Result := fFormataFone(strTelefo);
end;

function TfrmModuloFatImp.frxDocSep40UserFunction(const MethodName: string;
  var Params: Variant): Variant;
begin
  If SameText(MethodName, 'fRetLocFisica') Then
    Result := fRetLocFisica(Params[0], Params[1]);
end;

function TfrmModuloFatImp.frxDocSep80UserFunction(const MethodName: string;
  var Params: Variant): Variant;
begin

  If SameText(MethodName, 'fFormataFone') Then
  Begin
    Result := fFormataFoneInterna(Params[0]);
  End;

end;

function TfrmModuloFatImp.frxDocSep80_Mod4UserFunction(const MethodName: string; var Params: Variant): Variant;
  Var
    fltVal: Double;
    DiaDaSemana : array [1..7] of String;
begin
  If SameText(MethodName, 'fRetVal') Then
  Begin
    If Params[0] = 'QTDITE' Then
    Begin
      fltVal := 0;
      frxItens.Dataset.First;

      While Not frxItens.Dataset.Eof Do
      Begin
        fltVal := fltVal + frxItens.Dataset.FieldByName('QTDITE').AsFloat;
        frxItens.Dataset.Next;
      End;

      Result := FloatToStr(fltVal);
    End

    Else If Params[0] = 'QTDDIS' Then
      Result := IntToStr(frxItens.Dataset.RecordCount)

    Else If Params[0] = 'CNPJ' Then
      Result := fFormataCpfCgc(frxCadEmp.DataSet.FieldByName('EMP_C_G_C_').AsString, fSetaPais, frxCadEmp.DataSet.FieldByName('EMP_ESTADO').AsString)

    Else If Params[0] = 'DATA' Then
    Begin
      DiaDasemana [1]:= 'Domingo';
      DiaDasemana [2]:= 'Segunda-Feira';
      DiaDasemana [3]:= 'Terça-Feira';
      DiaDasemana [4]:= 'Quarta-Feira';
      DiaDasemana [5]:= 'Quinta-Feira';
      DiaDasemana [6]:= 'Sexta-Feira';
      DiaDasemana [7]:= 'Sábado';

      Result := DiaDaSemana[DayOfWeek(VS_Date)] + ', '+ FormatDateTime('dd/mm/yyyy hh:mm:ss', VS_Date + fTime());
    End

    Else If Params[0] = 'FONE' Then
      Result := fFormataFone(frxCadSep.DataSource.DataSet.FieldByName('TELCLI').AsString)
  End;
end;

function TfrmModuloFatImp.fRetLocFisica(strLocFis, strLocSup: String): String;
begin
  Result := '';

  If (Not fEmptyStr(strLocFis)) Then
  Begin
    Result := strLocFis;
  End;

  If (Not fEmptyStr(strLocSup)) Then
  Begin
    If (fEmptyStr(Result)) Then
      Result := strLocSup
    Else
      Result := Result + #13#10 + strLocSup;
  End;
end;

end.
