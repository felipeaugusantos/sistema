{**************************************************************************************}
{* Classe abstrata que implementa o b·sico / comum para a geraÁ„o da tinta Starmix *}
{***********************************************************************************AC*}
unit untAbstractGravandoExecucaoStarmix;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untTipoCadastro, Classes, StrUtils, untAutcomTintaFactory,
  UniClientDataSet, untFloatUtils, untIConfTinta, untIDataSet;

type
  TAbstractGravandoExecucaoStarmix = class(TInterfacedObject, IGravandoExecucaoNome)
  private

  protected
    qryInsert: IDataSet;
    cdsMontadoras,
    cdsLinhas,
    cdsBases,
    cdsFormulas: TUniClientDataSet;

    stlFormulas: TStringList;

    arqTxt: TextFile;

    conf: IConfTinta;

    function GetUniClient(): TUniClientDataSet;
    function fFormataAutInc(const intAutInc: Integer): String;
    function fValidaPath: Boolean;
    function GetPath: String;
    function fCfgTin(strNome: String): String;
    function fRemoveAcento(Str:String): String;


    procedure pCriandoCdsMontadoras;
    procedure pCriandoCdsLinhas;
    procedure pCriandoCdsBases;
    procedure pCriandoCdsFormulas;

    procedure pPreencheCdsMontadoras(const strArquivo: String);
    procedure pPreencheCdsLinhas(const strArquivo: String);
    procedure pPreencheCdsBases(const strArquivo: String);
    procedure pPreencheCdsFormulas(const strArquivo: String);

    procedure pPreenchendoCdsParaGeracao(const gravando: IGravando);

    function fCdsVazio: Boolean;

    procedure pCriandoCdsFormulasCODB;
    procedure pCriandoCdsFormulasQTDB;

    function fRetNomLin(strCodLin: String): String;
    function fRetNomMon(strCodMon: String): String;
  public
    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;
  end;

const intQtdForm = 20;

implementation

uses
  untStrUtils;

{ TGravandoExecucaoStarmixCores }

constructor TAbstractGravandoExecucaoStarmix.Create;
begin
  inherited Create;

  conf := TAutcomTintaFactory.Get.fGetConfTinta('STA');
  qryInsert:= TAutcomTintaFactory.Get.fGetDataSet;

  TAutcomTintaFactory.Get.fInsereProCod('STA_CADLIN');

  stlFormulas := TStringList.Create;

  pCriandoCdsMontadoras;
  pCriandoCdsLinhas;
  pCriandoCdsBases;
  pCriandoCdsFormulas;
end;

destructor TAbstractGravandoExecucaoStarmix.Destroy;
begin
  if Assigned(cdsLinhas) then FreeAndNil(cdsLinhas);
  if Assigned(cdsMontadoras) then FreeAndNil(cdsMontadoras);
  if Assigned(cdsBases) then FreeAndNil(cdsBases);
  if Assigned(cdsFormulas) then FreeAndNil(cdsFormulas);
  if Assigned(stlFormulas) then FreeAndNil(stlFormulas);
  inherited;
end;


function TAbstractGravandoExecucaoStarmix.fCdsVazio: Boolean;
begin
  Result := cdsFormulas.IsEmpty;
end;

function TAbstractGravandoExecucaoStarmix.fCfgTin(strNome: String): String;
begin
  Result := conf.fGet(strNome);
end;

function TAbstractGravandoExecucaoStarmix.fFormataAutInc(const intAutInc: Integer): String;
begin
  Result := TAutcomTintaFactory.Get.GetCodEmp +
    TStrUtils.fPadL(IntToStr(intAutInc) +
    TAutcomTintaFactory.Get.GetCodEmp, 17, '0');
end;

function TAbstractGravandoExecucaoStarmix.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoStarmix.fRemoveAcento(Str: String): String;
	Const
		ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸¿¬ ‘€√’¡…Õ”⁄«‹"¥';
		SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU  ';
	Var
		x : Integer;
Begin
	For x := 1 to Length(Str) do
		If Pos(Str[x],ComAcento)<>0 Then
			Str[x] := SemAcento[Pos(Str[x],ComAcento)];
  Result := Str;
end;

function TAbstractGravandoExecucaoStarmix.fRetNomLin(
  strCodLin: String): String;
begin
  cdsLinhas.Locate('CODIGO', strCodLin, []);
  Result := cdsLinhas.FieldByName('NOME').AsString;
end;

function TAbstractGravandoExecucaoStarmix.fRetNomMon(
  strCodMon: String): String;
begin
  cdsMontadoras.Locate('CODIGO', strCodMon, []);
  Result := cdsMontadoras.FieldByName('NOME').AsString;
end;

function TAbstractGravandoExecucaoStarmix.fValidaPath: Boolean;
begin
  Result := FileExists(GetPath);
end;

function TAbstractGravandoExecucaoStarmix.GetPath: String;
begin
  Result := conf.fGet('PATSTA');
end;

function TAbstractGravandoExecucaoStarmix.GetUniClient: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(nil);
end;

procedure TAbstractGravandoExecucaoStarmix.pPreencheCdsBases(
  const strArquivo: String);
begin
  If Trim(Copy(strArquivo, 299, 03)) = '30' Then
  Begin
    With cdsBases Do
    Begin
      Append;
      FieldByName('CODSEQ').AsString := Copy(strArquivo, 01, 04);
      FieldByName('CODIGO').AsString := Copy(strArquivo, 05, 08);
      FieldByName('NOME').AsString   := fRemoveAcento(Copy(strArquivo, 13, 44));
      FieldByName('CODLIN').AsString := Copy(strArquivo, 57, 03);
      FieldByName('PESESP').AsFloat  := TAutcomTintaFactory.Get.fStrToFloat(Copy(strArquivo, 60, 08)) / 10000;
      FieldByName('EMBALA').AsFloat  := TAutcomTintaFactory.Get.fStrToFloat(Copy(strArquivo, 68, 05));
      Post;
    End;
  End;
end;

procedure TAbstractGravandoExecucaoStarmix.pPreencheCdsFormulas(
  const strArquivo: String);
var
 intCont: Integer;
 intInicialQtd,
 intInicialForm: Integer;
begin
  If Copy(strArquivo, 314, 02) = '60' Then
  Begin
    With cdsFormulas Do
    Begin
      Append;
      FieldByName('CODIGO').AsString := Copy(strArquivo, 01, 08);
      FieldByName('NOMCOR').AsString := fRemoveAcento(Copy(strArquivo, 09, 45));
      FieldByName('OBSERV').AsString := fRemoveAcento(Copy(strArquivo, 54, 34));
      FieldByName('ANOCOR').AsString := Copy(strArquivo, 88, 04);
      FieldByName('PESCOR').AsFloat  := (TAutcomTintaFactory.Get.fStrToFloat(Copy(strArquivo, 92, 08)) / 10000.00);
      FieldByName('PESFOR').AsFloat  := (TAutcomTintaFactory.Get.fStrToFloat(Copy(strArquivo, 100, 08)) / 10000.00);
      FieldByName('DTAFOR').AsFloat  := TAutcomTintaFactory.Get.fStrToFloat(Copy(strArquivo, 108, 08));
      FieldByName('CODLIN').AsString := Copy(strArquivo, 116, 03);
      FieldByName('CODMON').AsString := Copy(strArquivo, 119, 03);
      FieldByName('UNIVER').AsString := Copy(strArquivo, 122, 12);

      intInicialQtd  := 134;
      intInicialForm := 138;

      For intCont := 1 To intQtdForm Do
      Begin
        If intCont > 15 Then
        Begin
          FieldByName('CODB' + TStrUtils.fStrZero(intCont, 2)).AsString := '';
          FieldByName('QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat  := 0.0;
        End
        Else
        Begin
          FieldByName('CODB' + TStrUtils.fStrZero(intCont, 2)).AsString := Copy(strArquivo, intInicialQtd, 04);

          intInicialQtd := intInicialQtd + 12;

          FieldByName('QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat  := TAutcomTintaFactory.Get.fStrToFloat(Copy(strArquivo, intInicialForm, 08));

          intInicialForm := intInicialForm + 12;
        End;
      End;

      Post;
    End;
  End;
end;

procedure TAbstractGravandoExecucaoStarmix.pPreencheCdsLinhas(const strArquivo: String);
begin
  If Copy(strArquivo, 299, 02) = '20' Then
  Begin
    With cdsLinhas Do
    Begin
      Append;
      FieldByName('CODIGO').AsString := Copy(strArquivo, 01, 03);
      FieldByName('NOME').AsString   := fRemoveAcento(Copy(strArquivo, 04, 30));
      FieldByName('VOLUME').AsFloat  := TAutcomTintaFactory.Get.fStrToFloat(Copy(strArquivo, 34, 06));
      Post;

      qryInsert.SQL := 'SELECT * FROM STA_CADLIN ';
      qryInsert.Open;

      If Not qryInsert.Locate('LIN_CODLIN',Copy(strArquivo, 01, 03), []) Then
      Begin
        qryInsert.Insert;
        qryInsert.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('STA_CADLIN', TAutcomTintaFactory.Get.GetCodEmp);
        qryInsert.FieldByName('LIN_CODLIN').AsString := Copy(strArquivo, 01, 03);
        qryInsert.FieldByName('LIN_DESLIN').AsString := fRemoveAcento(Copy(strArquivo, 04, 30));
        qryInsert.Post;
      End;

    End;
  End;
end;

procedure TAbstractGravandoExecucaoStarmix.pPreencheCdsMontadoras(
  const strArquivo: String);
begin
  If Copy(strArquivo, 299, 02) = '10' Then
  Begin
    With cdsMontadoras Do
    Begin
      Append;
      FieldByName('CODIGO').AsString := Copy(strArquivo, 01, 03);
      FieldByName('NOME').AsString   := fRemoveAcento(Copy(strArquivo, 04, 40));
      Post;
    End;
  End;
end;

procedure TAbstractGravandoExecucaoStarmix.pPreenchendoCdsParaGeracao(
  const gravando: IGravando);
var
  intCont: Integer;
begin
  If Not fCdsVazio Then
    Exit;

  Try
    Try
      stlFormulas.LoadFromFile(GetPath);

      For intCont := 0 To stlFormulas.Count -1 Do
      Begin
        pPreencheCdsMontadoras(stlFormulas[intCont]);
        pPreencheCdsLinhas(stlFormulas[intCont]);
        pPreencheCdsBases(stlFormulas[intCont]);
        pPreencheCdsFormulas(stlFormulas[intCont]);

        gravando.RegistrarProgresso(0, intCont, stlFormulas.Count);
      End;
    Except
      On E: Exception Do
      Begin
        gravando.Cancelar;
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally
    FreeAndNil(stlFormulas);
  End;
end;

procedure TAbstractGravandoExecucaoStarmix.pCriandoCdsBases;
begin
  cdsBases := GetUniClient;
  cdsBases.FieldDefs.Add('CODSEQ', ftString, 4);
  cdsBases.FieldDefs.Add('CODIGO', ftString, 8);
  cdsBases.FieldDefs.Add('NOME', ftString, 44);
  cdsBases.FieldDefs.Add('CODLIN', ftString, 3);
  cdsBases.FieldDefs.Add('PESESP', ftFloat);
  cdsBases.FieldDefs.Add('EMBALA', ftFloat);
  cdsBases.CreateDataSet;
end;

procedure TAbstractGravandoExecucaoStarmix.pCriandoCdsFormulas;
begin
  cdsFormulas := GetUniClient;
  cdsFormulas.FieldDefs.Add('CODIGO', ftString, 8);
  cdsFormulas.FieldDefs.Add('NOMCOR', ftString, 45);
  cdsFormulas.FieldDefs.Add('OBSERV', ftString, 34);
  cdsFormulas.FieldDefs.Add('ANOCOR', ftString, 4);
  cdsFormulas.FieldDefs.Add('PESCOR', ftFloat);
  cdsFormulas.FieldDefs.Add('PESFOR', ftFloat);
  cdsFormulas.FieldDefs.Add('DTAFOR', ftDate);
  cdsFormulas.FieldDefs.Add('CODLIN', ftString, 3);
  cdsFormulas.FieldDefs.Add('CODMON', ftString, 3);
  cdsFormulas.FieldDefs.Add('UNIVER', ftString, 12);

  pCriandoCdsFormulasCODB;
  pCriandoCdsFormulasQTDB;

  cdsFormulas.CreateDataSet;
end;

procedure TAbstractGravandoExecucaoStarmix.pCriandoCdsFormulasCODB;
var
  intCont: Integer;
begin
  For intCont := 1 To intQtdForm Do
  Begin
    cdsFormulas.FieldDefs.Add('CODB' + TStrUtils.fStrZero(intCont, 2), ftString, 4);
  End;
end;

procedure TAbstractGravandoExecucaoStarmix.pCriandoCdsFormulasQTDB;
var
  intCont: Integer;
begin
  For intCont := 1 To intQtdForm Do
  Begin
    cdsFormulas.FieldDefs.Add('QTDB' + TStrUtils.fStrZero(intCont, 2), ftFloat);
  End;
end;

procedure TAbstractGravandoExecucaoStarmix.pCriandoCdsLinhas;
begin
  cdsLinhas := GetUniClient;
  cdsLinhas.FieldDefs.Add('CODIGO', ftString, 3);
  cdsLinhas.FieldDefs.Add('NOME', ftString, 30);
  cdsLinhas.FieldDefs.Add('VOLUME', ftFloat);
  cdsLinhas.CreateDataSet;
end;

procedure TAbstractGravandoExecucaoStarmix.pCriandoCdsMontadoras;
begin
  cdsMontadoras := GetUniClient;
  cdsMontadoras.FieldDefs.Add('CODIGO', ftString, 3);
  cdsMontadoras.FieldDefs.Add('NOME', ftString, 40);
  cdsMontadoras.CreateDataSet;
end;

end.

