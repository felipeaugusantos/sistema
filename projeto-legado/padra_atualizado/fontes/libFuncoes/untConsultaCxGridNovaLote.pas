unit untConsultaCxGridNovaLote;

interface

uses
  System.SysUtils, System.Classes, untConsultaCxGridNova, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxEdit,
  cxTextEdit, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, Data.DB, cxDBData, Vcl.Menus, cxClasses, UniClientDataSet, MemDS,
  DBAccess, Uni, Datasnap.Provider, UniDataSetProvider, Vcl.Buttons,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCustomView, cxGrid, Vcl.StdCtrls, Vcl.Forms, cxVGrid,
  cxInplaceContainer, Vcl.ComCtrls, Vcl.Controls, Vcl.ExtCtrls,
  BitBtnLockedIncrem, untFuncoesGen;

type
  TfrmConsultaCxGridNovaLote = class(TfrmConsultaCxGridNova)
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure pAtualiza(tpcTipCon: TTipoConsulta; strFilter: String = ''); override;
  end;

var
  frmConsultaCxGridNovaLote: TfrmConsultaCxGridNovaLote;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TfrmConsultaCxGridNovaLote }

procedure TfrmConsultaCxGridNovaLote.pAtualiza(tpcTipCon: TTipoConsulta;
  strFilter: String);
  Var
    intIndice: Integer;
begin
  inherited;

  Try
    If (Not cdsConsulta.IsEmpty) And Assigned(pAtualizaLote) Then
    Begin
      pSetaClient(cdsConsulta);
      pAtualizaLote(cdsConsulta);

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
    End;
  Except
    On E: Exception Do
      Raise;
  End;
end;

end.
