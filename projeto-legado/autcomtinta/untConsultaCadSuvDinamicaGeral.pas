unit untConsultaCadSuvDinamicaGeral;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untConsultaComp, DB, 
   Uni, ExtCtrls, ComCtrls, Buttons, Grids,
  DBGridCitel, DBGrids, Mask, DBCtrls, DBEditFocus, BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCadSuvDinamicaGeral = class(TfrmConsultaComp)
    procedure FormShow(Sender: TObject);
    procedure edtFiltro1Change(Sender: TObject);
    procedure edtFiltro1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExecutaTarefaClick(Sender: TObject);
  private
    { Private declarations }
    procedure pDesabilitaColunas;
  protected
    procedure pAtuIndice(intIndice: Integer); override;
  public
    { Public declarations }
  end;

var
  frmConsultaCadSuvDinamicaGeral: TfrmConsultaCadSuvDinamicaGeral;

implementation

uses untFuncoesSimples, untSuvinilDinamica, untClientDataSetFactory;

{$R *.dfm}

{ TfrmConsultaCadSuv }

procedure TfrmConsultaCadSuvDinamicaGeral.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pDesabilitaColunas;
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  //dtsConsulta.DataSet := qryConsulta;
  qryConsulta.EnableControls;
end;

procedure TfrmConsultaCadSuvDinamicaGeral.pDesabilitaColunas;
begin
  qryConsulta.FieldByName('AUTOINCREM').Visible := False;
end;

procedure TfrmConsultaCadSuvDinamicaGeral.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
end;

procedure TfrmConsultaCadSuvDinamicaGeral.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadSuvDinamicaGeral.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadSuvDinamicaGeral.btnExecutaTarefaClick(
  Sender: TObject);
var
  qryGen: TUniQuery;
  strCodIte: String;
  strDesBas: String;
  strRefBas: String;
  strUniBas: String;
  strDesCor: String;
  fltPreCus: Double;
  fltUnitar: Double;
begin
  qryGen := nil;
  Try
    Try
      If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
        Exit;

      qryGen := fCriaQuery(Self);
      qryGen.SQL.Add('SELECT * FROM SUV_CADSUV WHERE AUTOINCREM = :AUTINC');
      qryGen.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;

      fDigDadosTintometricos(TClientDataSetFactory.GetClientDataSet(qryGen),
        '1', strCodIte, strDesBas, strRefBas, strUniBas, strDesCor, fltPreCus,
        fltUnitar, TDicionario.Create);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

end.

