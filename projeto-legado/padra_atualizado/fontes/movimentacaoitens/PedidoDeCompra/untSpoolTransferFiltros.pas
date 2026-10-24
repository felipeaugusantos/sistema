unit untSpoolTransferFiltros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Vcl.Mask, MaskEditFocus, untTypesSistema;

type
  TfrmSpoolTransferFiltros = class(TfrmPaiConfirma)
    Panel1: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    edtCodFor: TEditFocus;
    edtDesFor: TEditFocus;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    Label1: TLabel;
    edtPrdGru: TEditFocus;
    edtDesPrdGru: TEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    Label12: TLabel;
    edtRefere: TEditFocus;
    edtCodUni: TEditFocus;
    edtSigUni: TEditFocus;
    edtCodDep: TEditFocus;
    edtDesCodDep: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    Label15: TLabel;
    edtCodCmp: TEditFocus;
    edtDesCmp: TEditFocus;
    rdgLocfis: TRadioGroup;
    GroupBox1: TGroupBox;
    chkNivA: TCheckBox;
    chkNivB: TCheckBox;
    chkNivC: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSpoolTransferFiltros: TfrmSpoolTransferFiltros;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples,
  untFuncoesConsulta,
  untConsultas;

end.
