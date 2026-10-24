unit untSelecionaEmpresaTE;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, UniClientDataSet,
  UniDataSetProvider,   Uni, BitBtnLockedIncrem,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, MemDS, DBAccess, Datasnap.Provider, Datasnap.DBClient, frxClass,
  frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmSelecionaEmpresaTE = class(TfrmPai)
    gridEmpresasDBTableView1: TcxGridDBTableView;
    gridEmpresasLevel1: TcxGridLevel;
    gridEmpresas: TcxGrid;
    gridEmpresasCODEMP: TcxGridDBColumn;
    gridEmpresasNOMEMP: TcxGridDBColumn;
    qryCadEmp: TUniQuery;
    dspCadEmp: TUniDataSetProvider;
    cdsCadEmp: TUniClientDataSet;
    dtsCadEmp: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure gridEmpresasDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    blnAcessoTodasAsEmpresas : Boolean;
    procedure pCarregaEmpresas;
  public
    { Public declarations }
    strEmp_TE: String;
    blnEmpLog: Boolean;
    blnVeioFatVendas : Boolean;
    blnUsaMultiLoja : Boolean;
    blnValidarPermissoesTE_VENEMP: Boolean;
    blnValidarPermissoesTE_CONEMP: Boolean;
  end;

var
  frmSelecionaEmpresaTE: TfrmSelecionaEmpresaTE;

implementation

uses  untFuncoesSimples;

{$R *.dfm}

{ TfrmSelecionaEmpresaTE }

procedure TfrmSelecionaEmpresaTE.FormCreate(Sender: TObject);
begin
  inherited;
  blnEmpLog := False;
  blnVeioFatVendas := False;
  blnUsaMultiLoja := False;
  blnValidarPermissoesTE_VENEMP := False;
  blnValidarPermissoesTE_CONEMP := False;
end;

procedure TfrmSelecionaEmpresaTE.FormShow(Sender: TObject);
begin
  inherited;
  blnAcessoTodasAsEmpresas := (Not fCfgSis('ACEMPI', varBoolean));
  pCarregaEmpresas;

  pSetFocus(gridEmpresas);

end;

procedure TfrmSelecionaEmpresaTE.gridEmpresasDBTableView1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE: Begin
                 btnSair.Click;
               End;
    VK_RETURN: Begin
                 strEmp_TE   := cdsCadEmp.FieldByName('CODEMP').AsString;
                 ModalResult := mrOk;
               End;
  End;
end;

procedure TfrmSelecionaEmpresaTE.pCarregaEmpresas;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE              ';
  strSQL := strSQL + '       E.EMP_CODEMP CODEMP,      ';
  strSQL := strSQL + '       E.EMP_NOMEMP NOMEMP       ';
  strSQL := strSQL + ' FROM CADEMP E                   ';

  If (blnValidarPermissoesTE_VENEMP) Then
  Begin
    strSQL := strSQL + ' LEFT JOIN VENEMP V             ';
    strSQL := strSQL + ' ON(E.EMP_CODEMP = V.VEN_EMPDES) ';
  End;

  If (blnValidarPermissoesTE_CONEMP) Then
  Begin
    strSQL := strSQL + ' LEFT JOIN CONEMP C              ';
    strSQL := strSQL + ' ON(E.EMP_CODEMP = C.CON_EMPORI) ';
  End;

  strSQL := strSQL + ' WHERE E.EMP_CODEMP <> :CODEMP   ';
  strSQL := strSQL + ' AND E.EMP_CLIFIL IS NOT NULL    ';
  strSQL := strSQL + ' AND E.EMP_FORFIL IS NOT NULL    ';

  If (blnValidarPermissoesTE_VENEMP) Then
  Begin
    strSQL := strSQL + ' AND V.VEN_EMPORI = :CODEMP      ';
    strSQL := strSQL + ' AND IFNULL(V.VEN_PERTRE, "S") = "S"  ';
  End;

  If (blnValidarPermissoesTE_CONEMP) Then
  Begin
    strSQL := strSQL + ' AND C.CON_EMPDES = :CODEMP      ';
    strSQL := strSQL + ' AND IFNULL(C.CON_PERTRA, "S") = "S"  ';
  End;

  If (blnVeioFatVendas) And (Not blnAcessoTodasAsEmpresas) Then
  Begin
    If (blnUsaMultiLoja) Then
      strSQL := strSQL + ' AND (LOCATE(E.EMP_CODEMP, ' + QuotedStr(strEmpMultiLojaUsuarioLogado) + ') > 0) '
    Else
      strSQL := strSQL + ' AND (LOCATE(E.EMP_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0) ';
  End;

  With qryCadEmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString := IIF(Not blnEmpLog, VS_strCodEmp, '');
    Open;
  End;
  cdsCadEmp.Close;
  cdsCadEmp.Open;

end;

end.
