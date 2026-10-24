unit untTintasProdutosAcabadosIguais;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, AppEvnts, Menus, StdCtrls, Buttons,
  BitBtnLockedIncrem, ExtCtrls, Uni,  cxTextEdit,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmTintasProdutosAcabadosIguais = class(TfrmPai)
    dbgvDados: TcxGridDBTableView;
    dbglDados: TcxGridLevel;
    dbgDados: TcxGrid;
    dtsDados: TDataSource;
    dbcCodAca: TcxGridDBColumn;
    dbcDesCri: TcxGridDBColumn;
    dbcEmpEst: TcxGridDBColumn;
    dbcSaldos: TcxGridDBColumn;
    procedure dbgvDadosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    strIteTin: string;
    strCatali: string;
    strLinTin: string;
    strTipPre: string;
    strIdePro: string;
    fltVolPro: Double;
    qryDados: TUniQuery;
    procedure pConstruirDados;
    procedure pAjustarTela;
  public
    constructor Create(AOwner: TComponent; const strIteTin, strCatali, strLinTin, strTipPre, strIdePro: string; fltVolPro: Double); reintroduce;
    class function fExisteTintaJaProduzida(const strIteTin, strCatali, strLinTin, strTipPre, strIdePro: string; fltVolPro: Double): Boolean; stdcall;
    destructor Destroy; override;
    { Public declarations }
  end;

  function fExisteTintaJaProduzida(const strIteTin, strCatali, strLinTin, strTipPre, strIdePro: string; fltVolPro: Double): Boolean; stdcall;

var
  frmTintasProdutosAcabadosIguais: TfrmTintasProdutosAcabadosIguais;

implementation
uses untFuncoesSimples;
{$R *.dfm}

{ TfrmTintasProdutosAcabadosIguais }

constructor TfrmTintasProdutosAcabadosIguais.Create(AOwner: TComponent; const strIteTin, strCatali, strLinTin, strTipPre,
  strIdePro: string; fltVolPro: Double);
begin
  inherited Create(AOwner);
  Self.strIteTin := strIteTin;
  Self.strCatali := strCatali;
  Self.strLinTin := strLinTin;
  Self.strTipPre := strTipPre;
  Self.strIdePro := strIdePro;
  Self.fltVolPro := fltVolPro;
  Self.qryDados := fCriaQuery();
  Self.dtsDados.DataSet := Self.qryDados;
  pConstruirDados;
end;

procedure TfrmTintasProdutosAcabadosIguais.dbgvDadosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: begin
                 Close;
               end;
  end;
end;

destructor TfrmTintasProdutosAcabadosIguais.Destroy;
begin
  if Assigned(qryDados) then FreeAndNil(qryDados);
  inherited Destroy;
end;

class function TfrmTintasProdutosAcabadosIguais.fExisteTintaJaProduzida(const strIteTin, strCatali, strLinTin, strTipPre,
  strIdePro: string; fltVolPro: Double): Boolean;
var
  frmTintasProdutosAcabadosIguais: TfrmTintasProdutosAcabadosIguais;
begin
  Result := False;
  frmTintasProdutosAcabadosIguais := nil;
  Try
    Try
      frmTintasProdutosAcabadosIguais := TfrmTintasProdutosAcabadosIguais.Create(Application,
        strIteTin, strCatali, strLinTin, strTipPre, strIdePro, fltVolPro);

      if frmTintasProdutosAcabadosIguais.qryDados.IsEmpty then
        Exit;

      frmTintasProdutosAcabadosIguais.ShowModal;
      Result := True;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(frmTintasProdutosAcabadosIguais) then FreeAndNil(frmTintasProdutosAcabadosIguais);
  End;
end;

procedure TfrmTintasProdutosAcabadosIguais.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgDados);
end;

procedure TfrmTintasProdutosAcabadosIguais.pAjustarTela;
var
  intCont: Integer;
  intLargura: Integer;
begin
  dbgvDados.ApplyBestFit();
  intLargura := 0;

  for intCont := 0 to dbgvDados.ColumnCount - 1 do
  begin
    intLargura := intLargura + dbgvDados.Columns[intCont].Width;
  end;

  intLargura := intLargura + (2 * Self.BorderWidth);
  intLargura := intLargura + GetSystemMetrics(SM_CXVSCROLL) * 2;

  if intLargura > Self.ClientWidth then
    Self.ClientWidth := intLargura;
    
end;

procedure TfrmTintasProdutosAcabadosIguais.pConstruirDados;
  function fGetSql(const strNomTab: string): string;
  begin
    Result :=
      ' SELECT                                   ' +
      '   ACA_CODACA                             ' +
      '   , DET_DESCRI                           ' +
      '   , ACA_EMPEST                           ' +
      '   , ACA_SALDOS                           ' +
      ' FROM                                     ' +
      '   ' + strNomTab + ' T                    ' +
      '   INNER JOIN ACAGER A                    ' +
      '     ON T.DET_CODACA = A.ACA_CODACA       ' +
      '    AND T.DET_EMPACA = A.ACA_CODEMP       ' +
      ' WHERE IFNULL(DET_ITETIN, '''') = :ITETIN ' +
      '   AND ((IFNULL(DET_CATALI, '''') = :CATALI) OR (DET_CATALI = "N")) ' +
      '   AND IFNULL(DET_LINTIN, '''') = :LINTIN ' +
      '   AND IFNULL(DET_TIPPRE, '''') = :TIPPRE ' +
      '   AND IFNULL(DET_IDEPRO, '''') = :IDEPRO ' +
      '   AND IFNULL(DET_VOLPRO,    0) = :VOLPRO ' +
      '   AND A.ACA_EMPEST = :CODEMP             ' +
      '   AND A.ACA_SALDOS > 0                   '
  end;
begin
  qryDados.Close;
  qryDados.SQL.Text := fGetSql('TINDET');

  qryDados.ParamByName('ITETIN').AsString := strIteTin;
  qryDados.ParamByName('CATALI').AsString := strCatali;
  qryDados.ParamByName('LINTIN').AsString := strLinTin;
  qryDados.ParamByName('TIPPRE').AsString := strTipPre;
  qryDados.ParamByName('IDEPRO').AsString := strIdePro;
  qryDados.ParamByName('VOLPRO').AsFloat  := fltVolPro;
  qryDados.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryDados.Open;

  pAjustarTela;
end;

function fExisteTintaJaProduzida(const strIteTin, strCatali, strLinTin, strTipPre, strIdePro: string; fltVolPro: Double): Boolean;
begin
  Result := TfrmTintasProdutosAcabadosIguais.fExisteTintaJaProduzida(strIteTin,
    strCatali, strLinTin, strTipPre, strIdePro, fltVolPro);
end;

end.
