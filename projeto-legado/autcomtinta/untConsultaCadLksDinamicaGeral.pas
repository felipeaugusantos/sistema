unit untConsultaCadLksDinamicaGeral;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untConsultaComp, DB, 
   Uni, ExtCtrls, ComCtrls, Buttons, Grids,
  DBGridCitel, DBGrids, Mask, DBCtrls, DBEditFocus, BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCadLksDinamicaGeral = class(TfrmConsultaComp)
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
  frmConsultaCadLksDinamicaGeral: TfrmConsultaCadLksDinamicaGeral;

implementation

uses untLukscolorDinamica, untFuncoesSimples;

{$R *.dfm}

{ TfrmConsultaCadLks }

procedure TfrmConsultaCadLksDinamicaGeral.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pDesabilitaColunas;
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  //dtsConsulta.DataSet := qryConsulta;
  qryConsulta.EnableControls;
end;

procedure TfrmConsultaCadLksDinamicaGeral.pDesabilitaColunas;
begin
  qryConsulta.FieldByName('AUTOINCREM').Visible := False;
end;

procedure TfrmConsultaCadLksDinamicaGeral.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
end;

procedure TfrmConsultaCadLksDinamicaGeral.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadLksDinamicaGeral.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadLksDinamicaGeral.btnExecutaTarefaClick(
  Sender: TObject);
  Var
    qryConsulta01: TUniQuery;

    {*******************************************}
    {* VARIÁVEIS INTERNAS                      *}
    {****************************************MV*}
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
  qryConsulta01.SQL.Add('SELECT * FROM LKD_CADLKD WHERE AUTOINCREM = :AUTINC');
  qryConsulta01.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
  qryConsulta01.Open;

  If (Not fDigDadosTintometricos(qryConsulta01, strTabPre,
        qryConsulta01.FieldByName('LKD_CODITE').AsString, strCodIte, strDesBas,
        strRefBas, strUniBas, strDesCor, fltPreCus, fltUnitar, TDicionario.Create)) Then
  Begin
    Exit;
  End;

  FreeAndNil(qryConsulta01);
end;

end.
