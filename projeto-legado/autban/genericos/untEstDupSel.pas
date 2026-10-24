unit untEstDupSel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, Grids, DBGridCitel, DBGrids, StdCtrls, Menus, ComCtrls, DB,
  Buttons, ExtCtrls, StrUtils, AppEvnts, Uni;

type
  TfrmEstDupSel = class(TfrmPaiSimples)
    Panel1: TPanel;
    pnlDadosDup: TPanel;
    Label5: TLabel;
    Nome: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    lblProtesta: TLabel;
    edtCodCliBai: TEdit;
    edtNomCliBai: TEdit;
    edtCodPorBai: TEdit;
    edtNomPorBai: TEdit;
    edtNosNum: TEdit;
    edtHistor: TEdit;
    edtHistor2: TEdit;
    edtDesProtesta: TEdit;
    pnlTopo: TPanel;
    Panel2: TPanel;
    btnSai: TBitBtn;
    btnSelTodos: TBitBtn;
    btnConfirma: TBitBtn;
    pnlAux2: TPanel;
    pnlTotais: TPanel;
    Label21: TLabel;
    Label9: TLabel;
    edtTotalDup: TEdit;
    edtTotalSelecionado: TEdit;
    dbgDuplicatas: TDBGridCitel;
    btnDesTodos: TBitBtn;
    procedure btnSelTodosClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbgDuplicatasKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure dbgDuplicatasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgDuplicatasDrawDataCell(Sender: TObject; const Rect: TRect;
      Field: TField; State: TGridDrawState);
    procedure dbgDuplicatasDblClick(Sender: TObject);
    procedure dbgDuplicatasDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure dbgDuplicatasCellClick(Column: TColumn);
    procedure btnSairClick(Sender: TObject);
    procedure btnDesTodosClick(Sender: TObject);
  private
    { Private declarations }
    procedure pSelecionaDuplicata;
    procedure pAtualizaDados;
    function  fEstornaDuplicata(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli, strTabela: String): Boolean;
    function  fRetTotDup: String;
    function  fRetTotDupSel: String;
  public
    { Public declarations }
    strCodBco : String;
    strJuros  : String;
    blnEstorno: Boolean;
  end;

var
  frmEstDupSel: TfrmEstDupSel;

implementation

uses untModuloSPR, untFuncoes, untfuncoesSimples;

{$R *.dfm}

procedure TfrmEstDupSel.btnSelTodosClick(Sender: TObject);
  Var
    strSQL   : String;
    intRecNro: Integer;
    qryUptAtbRec: TUniQuery;
begin
  inherited;

  Try

    qryUptAtbRec := fCriaQuery(Self);

    intRecNro := frmModuloSPR.qryTemporaria.RecNo;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  TMP_ATBREC ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  CBI_MARCAD = "M" ';

    With qryUptAtbRec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;

    frmModuloSPR.qryTemporaria.Close;
    frmModuloSPR.qryTemporaria.Open;
    (frmModuloSPR.qryTemporaria.FieldByName('CBI_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';
    frmModuloSPR.qryTemporaria.RecNo := intRecNro;

    pAtualizaDados;
    dbgDuplicatas.SetFocus;

  Finally
    FreeAndNil(qryUptAtbRec);
  End;

end;

procedure TfrmEstDupSel.btnConfirmaClick(Sender: TObject);
  Var blnCancelou: Boolean;
begin
  inherited;

  If Not frmModuloSPR.qryTemporaria.IsEmpty Then
  Begin

    fStartTransaction;

    Try

      With frmModuloSPR.qryTemporaria Do
      Begin

        blnCancelou := False;

        First;

        While Not Eof Do
        Begin

          {***********************************}
          {* PASSA APENAS SE ESTIVER MARCADO *}
          {********************************AF*}
          If FieldByName('CBI_MARCAD').AsString = 'M' Then
          Begin

            {******************}
            {* SE FOR CAIXA 1 *}
            {***************AF*}
            If FieldByName('CTR_IDENTI').AsInteger = 1 Then
            Begin

              If fEstornaDuplicata( LeftStr(FieldByName('CBI_NUMDUP').AsString,
                                    Length(FieldByName('CBI_NUMDUP').AsString)-1),
                                    RightStr(FieldByName('CBI_NUMDUP').AsString,1),
                                    FieldByName('CBI_ESPDOC').AsString,
                                    FieldByName('CBI_CODEMP').AsString,
                                    FieldByName('CTR_CODCLI').AsString,
                                    'CADREC') Then
                blnCancelou := True;

            End

            {******************}
            {* SE FOR CAIXA 2 *}
            {***************AF*}
            Else
            Begin

              If fEstornaDuplicata( LeftStr(FieldByName('CBI_NUMDUP').AsString,
                                    Length(FieldByName('CBI_NUMDUP').AsString)-1),
                                    RightStr(FieldByName('CBI_NUMDUP').AsString,1),
                                    FieldByName('CBI_ESPDOC').AsString,
                                    FieldByName('CBI_CODEMP').AsString,
                                    FieldByName('CTR_CODCLI').AsString,
                                    'CADRECX') Then
                blnCancelou := True;

            End;

          End;
          Next;
        End;

        fCommit;

        If blnCancelou Then
          fMensagem('','Cancelamento efetuado com sucesso!',['&O K'])
        Else
          fMensagem('','Nenhuma duplicata foi cancelada!',['&O K']);

        btnSai.Click;
      End;

    Except
      fMensagem('','Não foi possivel efetuar o cancelamento!',['&O K']);
      fRollBack;
    End;

  End;

end;

procedure TfrmEstDupSel.pAtualizaDados;
Begin
  edtCodCliBai.Text        := frmModuloSPR.qryTemporaria.FieldByName('CTR_CODCLI').AsString;
  edtNomCliBai.Text        := frmModuloSPR.qryTemporaria.FieldByName('CLI_NOMCLI').AsString;

  edtCodPorBai.Text        := frmModuloSPR.qryTemporaria.FieldByName('CTR_CODPOR').AsString;
  edtNomPorBai.Text        := frmModuloSPR.qryTemporaria.FieldByName('POR_NOMPOR').AsString;

  edtNosNum.Text           := frmModuloSPR.qryTemporaria.FieldByName('CTR_NOSNUM').AsString;
  edtHistor.Text           := frmModuloSPR.qryTemporaria.FieldByName('CTR_HIST01').AsString;
  edtHistor2.Text          := frmModuloSPR.qryTemporaria.FieldByName('CTR_HIST02').AsString;

  If frmModuloSPR.qryTemporaria.FieldByName('CBI_PROTES').AsString = 'N' Then
  Begin
    edtDesProtesta.Text    := 'Não';
    edtDesProtesta.Font.Color := clmoneygreen;
  End
  Else
  Begin
    edtDesProtesta.Text    := 'Sim';
    edtDesProtesta.Font.Color := clRed;
  End;

  edtTotalDup.Text         := fRetTotDup;
  edtTotalSelecionado.Text := fRetTotDupSel;
End;

{****************************************}
{* RETORNA O VALOR TOTAL DAS DUPLICATAS *}
{*************************************AF*}
function TfrmEstDupSel.fRetTotDup: String;
  Var
    strSQL: String;
    qrySelAtbRec: TUniQuery;
Begin

  Result := '';

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  SUM(CBI_VALDUP) AS VALOR ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  TMP_ATBREC';

    With qrySelAtbRec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      Result := FloatToStrF(FieldByName('VALOR').AsCurrency,ffNumber,15,2);

      Close;
    End;

  Finally
    FreeAndNil(qrySelAtbRec);
  End;

End;

{***************************************}
{* RETORNA O VALOR TOTAL DA DUPLICATAS *}
{* SELECIONADAS                        *}
{************************************AF*}
function TfrmEstDupSel.fRetTotDupSel: String;
  Var
    strSQL: String;
    qryTotDupSel: TUniQuery;
Begin

  Result := '';

  Try

    qryTotDupSel := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  SUM(CBI_VALDUP) AS VALOR ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  TMP_ATBREC ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CBI_MARCAD = "M" ';

    With qryTotDupSel Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      Result := FloatToStrF(FieldByName('VALOR').AsCurrency,ffNumber,15,2);

      Close;
    End;

  Finally
    FreeAndNil(qryTotDupSel);
  End;

End;


procedure TfrmEstDupSel.dbgDuplicatasKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  pAtualizaDados;

end;

{***********************}
{* MARCA AS DUPLICATAS *}
{********************AF*}
procedure TfrmEstDupSel.pSelecionaDuplicata;
  Var
    strSQL   : String;
    intRecNro: Integer;
    qryUptAtbRec: TUniQuery;
Begin

  Try

    qryUptAtbRec := fCriaQuery(Self);

    intRecNro := frmModuloSPR.qryTemporaria.RecNo;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  TMP_ATBREC ';
    strSQL := strSQL + 'SET ';

    If frmModuloSPR.qryTemporaria.FieldByName('CBI_MARCAD').AsString = 'M' Then
      strSQL := strSQL + '  CBI_MARCAD = "D" '
    Else
      strSQL := strSQL + '  CBI_MARCAD = "M" ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CBI_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CBI_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  CBI_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI ';

    With qryUptAtbRec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := frmModuloSPR.qryTemporaria.FieldByName('CBI_NUMDUP').AsString;
      ParamByName('ESPDOC').AsString := frmModuloSPR.qryTemporaria.FieldByName('CBI_ESPDOC').AsString;
      ParamByName('CODEMP').AsString := frmModuloSPR.qryTemporaria.FieldByName('CBI_CODEMP').AsString;
      ParamByName('CODCLI').AsString := frmModuloSPR.qryTemporaria.FieldByName('CTR_CODCLI').AsString;
      ExecSQL;
      CLose;
    End;

    frmModuloSPR.qryTemporaria.Close;
    frmModuloSPR.qryTemporaria.Open;
    (frmModuloSPR.qryTemporaria.FieldByName('CBI_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';

    frmModuloSPR.qryTemporaria.RecNo := intRecNro;

  Finally
    FreeAndNil(qryUptAtbRec);
  End;

End;

procedure TfrmEstDupSel.FormShow(Sender: TObject);
begin
  inherited;
  pAtualizaDados;
  dbgDuplicatas.SetFocus;

end;

procedure TfrmEstDupSel.dbgDuplicatasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Escape: btnSair.Click;
    VK_Space : pSelecionaDuplicata;

    VK_Return: Begin
                  pSelecionaDuplicata;
                  dbgDuplicatas.SetFocus;
                End;

    VK_F5    : btnSelTodos.Click;
    VK_F10   : btnConfirma.Click;
  End;

  dbgDuplicatas.Refresh;


end;

procedure TfrmEstDupSel.dbgDuplicatasDrawDataCell(Sender: TObject;
  const Rect: TRect; Field: TField; State: TGridDrawState);
begin
  inherited;

end;

{*********************}
{* ESTORNA DUPLICATA *}
{******************AF*}
function TfrmEstDupSel.fEstornaDuplicata(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli, strTabela: String): Boolean;
  Var
    strSQL: String;
    qryUptDel: TUniQuery;
Begin

  Result := True;

  Try

    qryUptDel := fCriaQuery(Self);  

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + strTabela;
    strSQL := strSQL + ' SET ';
    strSQL := strSQL + '  CTR_BCOBOL = NULL, ';
    strSQL := strSQL + '  CTR_BCOENV = NULL, ';
    strSQL := strSQL + '  CTR_DTAENV = NULL ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI ';

    Try

      With qryUptDel Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDUP').AsString := strNumDup;
        ParamByName('PARCEL').AsString := strParcel;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('CODCLI').AsString := strCodCli;
        ExecSQL;
        Close;
      End;

      strSQL := '';
      strSQL := strSQL + 'DELETE ';
      strSQL := strSQL + 'FROM ';

      If strTabela = 'CADREC' Then
        strSQL := strSQL + '  CADCBI '
      Else
        strSQL := strSQL + '  CADCBIX ';

      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CBI_NUMDUP = :NUMDUP AND ';
      strSQL := strSQL + '  CBI_PARCEL = :PARCEL AND ';
      strSQL := strSQL + '  CBI_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '  CBI_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  CBI_CODCLI = :CODCLI ';

      With qryUptDel Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDUP').AsString := strNumDup;
        ParamByName('PARCEL').AsString := strParcel;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('CODCLI').AsString := strCodCli;
        ExecSQL;
        Close;
      End;

    Except
      Result := False;
    End;

  Finally
    FreeAndNil(qryUptDel);
  End;

End;

procedure TfrmEstDupSel.dbgDuplicatasDblClick(Sender: TObject);
begin
  inherited;
  pSelecionaDuplicata;
  pAtualizaDados;

end;

procedure TfrmEstDupSel.dbgDuplicatasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  If frmModuloSPR.qryTemporaria.FieldByName('CBI_MARCAD').AsString = 'M' Then
    dbgDuplicatas.Canvas.Font.Color := clBlue;

  dbgDuplicatas.DefaultDrawColumnCell(Rect,DataCol,Column,State);


end;

procedure TfrmEstDupSel.dbgDuplicatasCellClick(Column: TColumn);
begin
  inherited;
  pAtualizaDados;

end;

procedure TfrmEstDupSel.btnSairClick(Sender: TObject);
begin
  inherited;

  frmEstDupSel.Close;

end;

procedure TfrmEstDupSel.btnDesTodosClick(Sender: TObject);
  Var
    strSQL   : String;
    intRecNro: Integer;
    qryUptAtbRec: TUniQuery;
begin
  inherited;

  Try

    qryUptAtbRec := fCriaQuery(Self);

    intRecNro := frmModuloSPR.qryTemporaria.RecNo;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  TMP_ATBREC ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  CBI_MARCAD = "D" ';

    With qryUptAtbRec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;

    frmModuloSPR.qryTemporaria.Close;
    frmModuloSPR.qryTemporaria.Open;
    (frmModuloSPR.qryTemporaria.FieldByName('CBI_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';
    frmModuloSPR.qryTemporaria.RecNo := intRecNro;

    pAtualizaDados;
    dbgDuplicatas.SetFocus;

  Finally
    FreeAndNil(qryUptAtbRec);
  End;

end;

end.
