unit untQckNotaPromissoria;

interface

uses
  System.SysUtils, System.Classes, frxClass, frxDMPExport, frxDBSet, Data.DB,
  Datasnap.DBClient, UniClientDataSet, Forms, untFuncoesGenerica;

type
  TfrmQckNotaPromissoria = class(TForm)
    frxPromissoria_M: TfrxReport;
    frxMatricial: TfrxDotMatrixExport;
    frxPromissoria_J: TfrxReport;
    frxDatasetDup: TfrxDBDataset;
    frxPromissoria40_M: TfrxReport;
    frxPromissoria40_J: TfrxReport;
    procedure DataModuleCreate(Sender: TObject);
    function frxPromissoria_MUserFunction(const MethodName: string;
      var Params: Variant): Variant;
  private
    { Private declarations }
    FPais: TPais;
    function fFormataCpfCgcInterna(strValor: String): String;
    function fVerificaComponenteRelExiste(strComponente,
      strInformacao: String): Boolean;
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, untValorPorExtenso;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TfrmQckNotaPromissoria.DataModuleCreate(Sender: TObject);
begin
  FPais   := fSetaPais;

  frxPromissoria40_M.AddFunction('function fFormataCpfCgcInterna(strValor: String): String;');
  frxPromissoria40_M.AddFunction('function fFormataCEP(strCEP: String): String;');
  frxPromissoria40_M.AddFunction('function fFormataFone(strFone: String): String;');
  frxPromissoria40_M.AddFunction('function fRetExtensoNumero(Value : String):String;');

  frxPromissoria_M.AddFunction('function fFormataCpfCgcInterna(strValor: String): String;');
  frxPromissoria_M.AddFunction('function fFormataCEP(strCEP: String): String;');
  frxPromissoria_M.AddFunction('function fFormataFone(strFone: String): String;');
  frxPromissoria_M.AddFunction('function fRetExtensoNumero(Value : String):String;');
  frxPromissoria_M.AddFunction('function fVerificaComponenteRelExiste(strComponente, strInformacao : String):Boolean');

  frxPromissoria40_J.AddFunction('function fFormataCpfCgcInterna(strValor: String): String;');
  frxPromissoria40_J.AddFunction('function fFormataCEP(strCEP: String): String;');
  frxPromissoria40_J.AddFunction('function fFormataFone(strFone: String): String;');
  frxPromissoria40_J.AddFunction('function fRetExtensoNumero(Value : String):String;');

  frxPromissoria_J.AddFunction('function fFormataCpfCgcInterna(strValor: String): String;');
  frxPromissoria_J.AddFunction('function fFormataCEP(strCEP: String): String;');
  frxPromissoria_J.AddFunction('function fFormataFone(strFone: String): String;');
  frxPromissoria_J.AddFunction('function fRetExtensoNumero(Value : String):String;');
end;

function TfrmQckNotaPromissoria.fFormataCpfCgcInterna(strValor: String): String;
begin
  Result := fFormataCpfCgc(strValor, FPais);
end;

function TfrmQckNotaPromissoria.frxPromissoria_MUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If SameText(MethodName, 'fFormataCpfCgcInterna') Then
    Result := fFormataCpfCgcInterna(Params[0]);

  If SameText(MethodName, 'fFormataCEP') Then
    Result := fFormataCEP(Params[0]);

  If SameText(MethodName, 'fFormataFone') Then
    Result := fFormataFone(Params[0]);

  If SameText(MethodName, 'fRetExtensoNumero') Then
    Result := fRetExtensoNumero(Params[0]);

  If MethodName = 'FVERIFICACOMPONENTERELEXISTE' Then
    Result := fVerificaComponenteRelExiste(Params[0],Params[1]);
end;

function TfrmQckNotaPromissoria.fVerificaComponenteRelExiste(strComponente,
                                                        strInformacao: String) : Boolean;
begin
  Result := False;
  If Assigned(frxPromissoria_M.FindObject(strComponente)) Then
  Begin
    TfrxMemoView(frxPromissoria_M.FindObject(strComponente)).Memo.Text := strInformacao;
    Result := True;
  End;
end;


end.
