unit untRcxConsTransfValores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, EditFocus,
  Uni, UniClientDataSet, UniDataSetProvider, StrUtils, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog, untRcxTResumoDeCaixa;

type
  TfrmRcxConsTransfValores = class(TfrmPai)
    pnlTransferencias: TPanel;
    dbgTransferenciasDBTableView1: TcxGridDBTableView;
    dbgTransferenciasLevel1: TcxGridLevel;
    dbgTransferencias: TcxGrid;
    dbgTransferenciasDBTableView1RCX_CODOPE: TcxGridDBColumn;
    dbgTransferenciasDBTableView1RCX_DINREC: TcxGridDBColumn;
    dbgTransferenciasDBTableView1RCX_CHQAVI: TcxGridDBColumn;
    dbgTransferenciasDBTableView1RCX_CHQPRE: TcxGridDBColumn;
    dbgTransferenciasDBTableView1RCX_CARREC: TcxGridDBColumn;
    dbgTransferenciasDBTableView1RCX_ORDREC: TcxGridDBColumn;
    dbgTransferenciasDBTableView1RCX_VALFIN: TcxGridDBColumn;
    dbgTransferenciasDBTableView1RCX_TOTGER: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    pnlMensagem: TPanel;
    Label12: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    qryTransf: TUniQuery;
    dtsTransf: TDataSource;
    cdsTransf: TUniClientDataSet;
    procedure pCriaTemporaria;
  public
    strCodigoCaixa  : String;
    objResumoDeCaixa: TResumoDeCaixa;

    strCodigoOperador: String;

    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untCadRcxx;

{$R *.dfm}

procedure TfrmRcxConsTransfValores.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgTransferencias);
end;

procedure TfrmRcxConsTransfValores.FormCreate(Sender: TObject);
begin
  inherited;
  strCodigoCaixa := '';

  cdsTransf := TUniCLientDataSet.Create(Self);
  dtsTransf := fCriaDataSource(cdsTransf);
  dbgTransferenciasDBTableView1.DataController.DataSource := dtsTransf;
end;

procedure TfrmRcxConsTransfValores.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(dtsTransf);
  FreeAndNil(cdsTransf);
end;

procedure TfrmRcxConsTransfValores.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_ESCAPE Then
    btnSair.Click;
end;

procedure TfrmRcxConsTransfValores.FormShow(Sender: TObject);
begin
  inherited;
  pCriaTemporaria;
end;

procedure TfrmRcxConsTransfValores.pCriaTemporaria;
  Var
    fltSalFec : Double;
    dtaDtaFec : TDateTime;

    blnTransferenciaCega: Boolean;
begin
  blnTransferenciaCega := fCfgSis('TRFCEG', varBoolean);

  Try
    objResumoDeCaixa.fRetornaUltimoFechamento(fltSalFec, dtaDtaFec, strCodigoCaixa);

    qryTransf := fCriaQuery(Self);
    With qryTransf Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(objResumoDeCaixa.fGetSQLTransfValores('', '', True, strCodigoCaixa));
      ParamByName('DTACAD').AsDateTime := dtaDtaFec;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Options.SetFieldsReadOnly := False;
      Open;
    End;

    pSetaClientDataSet(qryTransf, cdsTransf);
    cdsTransf.Open;

    TFloatField(cdsTransf.FieldByName('RCX_DINREC')).DisplayFormat := fDisplayFormat(2);
    TFloatField(cdsTransf.FieldByName('RCX_CHQAVI')).DisplayFormat := fDisplayFormat(2);
    TFloatField(cdsTransf.FieldByName('RCX_CHQPRE')).DisplayFormat := fDisplayFormat(2);
    TFloatField(cdsTransf.FieldByName('RCX_CARREC')).DisplayFormat := fDisplayFormat(2);
    TFloatField(cdsTransf.FieldByName('RCX_ORDREC')).DisplayFormat := fDisplayFormat(2);
    TFloatField(cdsTransf.FieldByName('RCX_VALFIN')).DisplayFormat := fDisplayFormat(2);
    TFloatField(cdsTransf.FieldByName('RCX_TOTGER')).DisplayFormat := fDisplayFormat(2);

    If blnTransferenciaCega Then
    Begin
      cdsTransf.DisableControls;
      cdsTransf.First;

      While Not cdsTransf.EOF Do
      Begin
          cdsTransf.Edit;
          If cdsTransf.FieldByName('RCX_DINREC').AsFloat <> 0 Then
            cdsTransf.FieldByName('RCX_TOTGER').AsFloat := cdsTransf.FieldByName('RCX_TOTGER').AsFloat -
                                                           cdsTransf.FieldByName('RCX_DINREC').AsFloat;
          cdsTransf.Post;

          cdsTransf.Next;
      End;

      cdsTransf.First;
      cdsTransf.EnableControls;
    End;

    dbgTransferenciasDBTableView1RCX_DINREC.Visible := (Not blnTransferenciaCega) Or
                                                       ((objResumoDeCaixa.strTipoFechamento = 'C') And
                                                        (fVerPermissaoOperador('LIBLANRCXDIV', strCodigoOperador)));
    pnlMensagem.Visible := Not dbgTransferenciasDBTableView1RCX_DINREC.Visible;

    FreeAndNil(qryTransf);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmRcxCancTransfValores.pCriaTemporaria]');
    End;
  End;
end;

end.
