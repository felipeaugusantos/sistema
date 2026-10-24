unit untConsultaCadDacDinamica;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms, 
  Dialogs, StdCtrls, untConsultaComp, DB, 
   Uni, ExtCtrls, ComCtrls, Buttons, Grids,
  DBGridCitel, DBGrids, Mask, DBCtrls, DBEditFocus, BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCadDacDinamica = class(TfrmConsultaComp)
    procedure FormShow(Sender: TObject);
    procedure edtFiltro1Change(Sender: TObject);
    procedure edtFiltro1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure pDesabilitaColunas;
  protected
    procedure pAtuIndice(intIndice: Integer); override;
  public
    { Public declarations }
  end;

var
  frmConsultaCadDacDinamica: TfrmConsultaCadDacDinamica;

implementation

{$R *.dfm}

{ TfrmConsultaCadDacDinamica }

procedure TfrmConsultaCadDacDinamica.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pDesabilitaColunas;
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  //dtsConsulta.DataSet := qryConsulta;
  qryConsulta.EnableControls;
end;

procedure TfrmConsultaCadDacDinamica.pDesabilitaColunas;
begin
  qryConsulta.FieldByName('AUTOINCREM').Visible := False;
end;

procedure TfrmConsultaCadDacDinamica.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
end;

procedure TfrmConsultaCadDacDinamica.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadDacDinamica.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

end.
