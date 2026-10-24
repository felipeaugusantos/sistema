unit untRelCadAutAba;

interface

uses
  SysUtils, Classes, frxClass, frxDBSet, DB, Forms;

type
  TfrmRelCadAutAba = class(TForm)
    frxReportJato: TfrxReport;
    frxDBAutAba: TfrxDBDataset;
    frxReportMatricial: TfrxReport;
    function frxReportJatoUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxReportMatricialUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses  untFuncoesSimples;

{$R *.dfm}

procedure TfrmRelCadAutAba.DataModuleCreate(Sender: TObject);
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

  frxReportJato.AddFunction('function fRetornaDescricaoVeic(strPlaVei: String): String;');
  frxReportJato.AddFunction('function fRetNomFornecedor(strCodFor: String): String;');
  frxReportJato.AddFunction('function fRetNomeMotorista(strCodMot: String): String;');
  frxReportJato.AddFunction('function fRetNomeEmpresaSelec(strCodEmp: String): String');
  frxReportMatricial.AddFunction('function fRetornaDescricaoVeic(strPlaVei: String): String;');
  frxReportMatricial.AddFunction('function fRetNomFornecedor(strCodFor: String): String;');
  frxReportMatricial.AddFunction('function fRetNomeMotorista(strCodMot: String): String;');
  frxReportMatricial.AddFunction('function fRetNomeEmpresaSelec(strCodEmp: String): String');
end;

function TfrmRelCadAutAba.frxReportJatoUserFunction(const MethodName: string;
  var Params: Variant): Variant;
begin
  inherited;
  If SameText('fRetornaDescricaoVeic', MethodName) Then
    Result := fRetornaDescricaoVeic(Params[0]);

  If SameText('fRetNomFornecedor', MethodName) Then
    Result := fRetNomFornecedor(Params[0]);

  If SameText('fRetNomeMotorista', MethodName) Then
    Result := fRetNomeMotorista(Params[0]);

  If SameText('fRetNomeEmpresaSelec', MethodName) Then
    Result := fRetNomeEmpresaSelec(Params[0]);
end;

function TfrmRelCadAutAba.frxReportMatricialUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If SameText('fRetornaDescricaoVeic', MethodName) Then
    Result := fRetornaDescricaoVeic(Params[0]);

  If SameText('fRetNomFornecedor', MethodName) Then
    Result := fRetNomFornecedor(Params[0]);

  If SameText('fRetNomeMotorista', MethodName) Then
    Result := fRetNomeMotorista(Params[0]);

  If SameText('fRetNomeEmpresaSelec', MethodName) Then
    Result := fRetNomeEmpresaSelec(Params[0]);    
end;

end.
