unit untConsultaCadSheDinamicaGeral;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untConsultaComp, DB, 
   Uni, ExtCtrls, ComCtrls, Buttons, Grids,
  DBGridCitel, DBGrids, Mask, DBCtrls, DBEditFocus;

type
  TfrmConsultaCadSheDinamicaGeral = class(TfrmConsultaComp)
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
  frmConsultaCadSheDinamicaGeral: TfrmConsultaCadSheDinamicaGeral;

implementation

uses untFuncoesSimples, untSherwinWhilliamsDinamica;

{$R *.dfm}

{ TfrmConsultaCadShe }

procedure TfrmConsultaCadSheDinamicaGeral.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pDesabilitaColunas;
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  //dtsConsulta.DataSet := qryConsulta;
  qryConsulta.EnableControls;
end;

procedure TfrmConsultaCadSheDinamicaGeral.pDesabilitaColunas;
begin
  qryConsulta.FieldByName('AUTOINCREM').Visible := False;
end;

procedure TfrmConsultaCadSheDinamicaGeral.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
end;

procedure TfrmConsultaCadSheDinamicaGeral.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadSheDinamicaGeral.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadSheDinamicaGeral.btnExecutaTarefaClick(
  Sender: TObject);
  Var
    qryConsulta01: TUniQuery;

    fltPreCus: Double;
    fltUnitar: Double;
    strCodIte: String;
    strDesCor: String;
    strTabPre: String;
    strDesBas: String;
    strRefBas: String;
    strUniBas: String;
begin
  inherited;

  strTabPre := '1';

  If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
    Exit;

  qryConsulta01 := fCriaQuery(Self);
  qryConsulta01.SQL.Add('SELECT * FROM SHE_CADSHE WHERE AUTOINCREM = :AUTINC');
  qryConsulta01.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
  qryConsulta01.Open;

  If (Not fDigDadosTintometricos(qryConsulta01, strTabPre,
        qryConsulta01.FieldByName('SHE_CODITE').AsString, strCodIte, strDesBas,
        strRefBas, strUniBas, strDesCor, fltPreCus, fltUnitar, TDicionario.Create)) Then
  Begin
    Exit;
  End;

  FreeAndNil(qryConsulta01);
end;

end.
