unit untCadControleEntrega;

interface

uses
  Windows, Classes, Forms, untPaiConfirma, AppEvnts, Menus, Buttons, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit,
  DB, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxControls, cxGridCustomView, cxGrid,
  Uni, untControleEntregaRomaneio, UniDataSetProvider, UniClientDataSet, untModulo,
  BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, MemDS, DBAccess, Provider, StdCtrls, Controls,
  frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient, untTLock;

type
  TfrmCadControleEntrega = class(TfrmPaiConfirma)
    cxGrid: TcxGrid;
    cxGridTableView: TcxGridDBTableView;
    cxGridColData: TcxGridDBColumn;
    cxGridColManha: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    dtsConEnt: TDataSource;
    Panel1: TPanel;
    rdgFiltro: TRadioGroup;
    cdsConEnt: TUniClientDataSet;
    dspConEnt: TUniDataSetProvider;
    qryConEnt: TUniQuery;
    cxGridColDia: TcxGridDBColumn;
    cdsConEntAUTOINCREM: TStringField;
    cdsConEntENT_CODEMP: TStringField;
    cdsConEntENT_DTAENT: TDateField;
    cdsConEntENT_DISPE1: TIntegerField;
    cdsConEntDIASEM: TStringField;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    btnIncluir: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rdgFiltroClick(Sender: TObject);
    procedure cdsConEntDIASEMGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure cdsConEntAfterPost(DataSet: TDataSet);
    procedure cdsConEntBeforePost(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

    objConEnt: TControleEntregaRomaneio;
    objLock: TLock;

    Procedure pAbreConsulta;

  public
    { Public declarations }
  end;


implementation

uses SysUtils, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadControleEntrega.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If objLock.fLock_Unlock('INCLUI_PERIODO_ENTREGA_ROMANEIO', True, False) Then
  Begin
    objConEnt.pPedePeriodoInclusao;
    pAbreConsulta;
    objLock.fLock_Unlock('INCLUI_PERIODO_ENTREGA_ROMANEIO', False);
  End

  Else fMensagem('ATENÇÃO!', 'Essa função está sendo utilizada por outra estação: ' +
         fGetHostLock('INCLUI_PERIODO_ENTREGA_ROMANEIO'), ['&Ok']);

end;

procedure TfrmCadControleEntrega.cdsConEntAfterPost(DataSet: TDataSet);
begin
  inherited;

  cdsConEnt.ApplyUpdates(0);

end;

procedure TfrmCadControleEntrega.cdsConEntBeforePost(DataSet: TDataSet);
begin
  inherited;

  With DataSet Do
  Begin
    If (FieldByName('ENT_DISPE1').AsInteger < 0) Then
    Begin
      pMensagemOk('O número de entregas disponíveis deve ser maior ou igual a zero');
      Cancel;
      Abort;
      Exit;
    End;

  End;
end;

procedure TfrmCadControleEntrega.cdsConEntDIASEMGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;

  Case DayOfWeek(cdsConEnt.FieldByName('ENT_DTAENT').AsDateTime) Of
    1: Text := 'DOMINGO';
    2: Text := 'SEGUNDA-FEIRA';
    3: Text := 'TERÇA-FEIRA';
    4: Text := 'QUARTA-FEIRA';
    5: Text := 'QUINTA-FEIRA';
    6: Text := 'SEXTA-FEIRA';
    7: Text := 'SÁBADO';
  End;

end;

procedure TfrmCadControleEntrega.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If (qryConEnt.State = dsEdit) Then
    qryConEnt.Post;
  If Assigned(objLock) Then
    FreeAndNil(objLock);
end;

procedure TfrmCadControleEntrega.FormCreate(Sender: TObject);
begin
  inherited;

  objConEnt := TControleEntregaRomaneio.Create;
  objLock   := TLock.Create;

  pAbreConsulta;
end;

Procedure TfrmCadControleEntrega.pAbreConsulta;
Begin
  With qryConEnt, SQL Do
  Begin
    cdsConEnt.Close;
    Close;

    Clear;
    Add('SELECT * FROM CONENT');
    Add('WHERE ENT_DTAENT >= :DTAENT AND');
    Add('      ENT_CODEMP = :CODEMP');

    ParamByName('DTAENT').AsDate   := VS_Date;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    cdsConEnt.Open;
  End;
End;

procedure TfrmCadControleEntrega.rdgFiltroClick(Sender: TObject);
begin
  inherited;

  With cdsConEnt Do
  Case rdgFiltro.ItemIndex Of
    0: Filtered := False;
    1: Begin
         Filter   := 'ENT_DISPE1 > 0';
         Filtered := True;
       End;
  End;
end;

procedure TfrmCadControleEntrega.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(objConEnt);
end;

procedure TfrmCadControleEntrega.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(cxGrid);
end;

end.
