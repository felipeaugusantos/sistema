unit untConsultaCxGridLote;

interface

uses
  System.SysUtils, System.Classes, untConsultaCxGrid, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, UniProvider, MySQLUniProvider, cxClasses,
  Vcl.ExtCtrls, UniClientDataSet, MemDS, DBAccess, Uni, Datasnap.Provider,
  UniDataSetProvider, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Buttons, BitBtnLockedIncrem, Vcl.Controls, untFuncoesGen;

type
  TfrmConsultaCxGridLote = class(TfrmConsultaCxGrid)
    procedure btnPadraoClick(Sender: TObject);
  private
    { Private declarations }
    procedure pEscondeCampos;
  public
    { Public declarations }
  protected
    procedure pAtualiza(tpcTipCon: TTipoConsulta; strFilter: String = ''); override;
  end;

var
  frmConsultaCxGridLote: TfrmConsultaCxGridLote;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TfrmConsultaCxGridLote }

procedure TfrmConsultaCxGridLote.btnPadraoClick(Sender: TObject);
begin
  inherited;

  pEscondeCampos;
end;

procedure TfrmConsultaCxGridLote.pAtualiza(tpcTipCon: TTipoConsulta;
  strFilter: String);
begin
  inherited;

  Try
    If (Not cdsConsulta.IsEmpty) And Assigned(pAtualizaLote) Then
    Begin
      pSetaClient(cdsConsulta);
      pAtualizaLote(cdsConsulta);
      pEscondeCampos;
    End;
  Except
    On E: Exception Do
      Raise;
  End;
end;

procedure TfrmConsultaCxGridLote.pEscondeCampos;
  Var
    intIndice: Integer;
begin
  If cdsConsulta.FindField('LOT_CODEMP') <> Nil Then
    cdsConsulta.FieldByName('LOT_CODEMP').Visible := False;

  If cdsConsulta.FindField('LOT_CODITE') <> Nil Then
    cdsConsulta.FieldByName('LOT_CODITE').Visible := False;

  For intIndice := 0 To cxConsultaView.ColumnCount - 1 Do
  Begin
    If cxConsultaView.Columns[intIndice].DataBinding.FieldName = 'LOT_CODEMP' Then
      cxConsultaView.Columns[intIndice].Visible := False;

    If cxConsultaView.Columns[intIndice].DataBinding.FieldName = 'LOT_CODITE' Then
      cxConsultaView.Columns[intIndice].Visible := False;
  End;
end;

end.
