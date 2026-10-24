unit untFatBaixaClubeFidelidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
   Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask, UITypes,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls,
  untFuncFat, StrUtils, MaskUtils, BitBtnLockedIncrem,
  ComCtrls, MemDS, DBAccess, Provider, frxClass, frxExportCSVTestabilidade,
  Datasnap.DBClient, cxProgressBar, untLiberacao, untTLock, Vcl.DBCtrls,
  DBEditFocus;

type
  TfrmFatBaixaClubeFidelidade = class(TfrmPaiOrdena)
    btnConfirma: TBitBtnLocked;
    Label1: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    Label2: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label3: TLabel;
    mskDtaFin: TMaskEditFocus;
    Label4: TLabel;
    edtDesEmpresa: TEditFocus;
    edtCodEmp: TEditFocus;
    btnMarTodos: TBitBtnLocked;
    btnDesTodos: TBitBtnLocked;
    Label5: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbgConsultaDblClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnMarTodosClick(Sender: TObject);
    procedure btnDesTodosClick(Sender: TObject);
    procedure dbgConsultaDrawDataCell(Sender: TObject; const Rect: TRect;
      Field: TField; State: TGridDrawState);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    qryAuxiliar : TUniQuery;
    LastKey   : Word;
//    procedure pInicializaTemporaria;
    procedure pLimpaConsulta(idxRdg:Integer=0);
    procedure pCarregaCliente;
    procedure pCarregaEmpresa;

  public
    { Public declarations }
    blnBaixa   : Boolean;
    strCodigo  : String;
    strCliente : String;
    strEmpresa : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fGetSql(blnLike: Boolean): String; Override;
    function fSetParametros: Boolean; Override;
    function fAbreConsulta(blnLike: Boolean): Boolean; Override;
  end;


implementation

uses  Math, untConsultas, untTypesSistema,
      untPai, untGravando,untFuncoesSimples,
      untPesqAux, untFuncFatTypes, untFuncoes,
      untConstantes;

{$R *.dfm}

procedure TfrmFatBaixaClubeFidelidade.pCarregaCliente;
begin
  pPesquisaCadCli(qryAuxiliar, qryAuxiliar, edtCodCli.Text);
  If Not (fEmptyStr(edtCodCli.Text)) Then
    edtNomCli.Text := qryAuxiliar.FieldByName('CLI_NOMCLI').AsString
  Else
    edtNomCli.Text := '';
end;

procedure TfrmFatBaixaClubeFidelidade.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryAuxiliar, qryAuxiliar, edtCodEmp.Text);
  If Not (fEmptyStr(edtCodEmp.Text)) Then
    edtDesEmpresa.Text := qryAuxiliar.FieldByName('EMP_NOMEMP').AsString
  Else
    edtDesEmpresa.Text := '';
end;

function TfrmFatBaixaClubeFidelidade.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        mskDtaFin.Clear;
        mskDtaFin.Enabled := False;
      End
      Else
      Begin
        mskDtaFin.Enabled := True;
      End;

    End

    Else If (Sender = mskDtaFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
          Result := False;
        End
      End;
    End

    Else If (Sender = edtCodCli) Then
    Begin

      If fEmptyStr(edtCodCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o código do cliente!', ['&Ok']);
        Result := FALSE;
      End
      Else
      Begin
        pCarregaCliente;
        If fEmptyStr(edtNomCli.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Cliente não cadastrado!', ['&Ok']);
          Result := FALSE;
        End
      End
    End

    Else If (Sender = edtCodEmp) Then
    Begin

      If (Not fEmptyStr(edtCodEmp.Text)) Then
      Begin
        pCarregaEmpresa;
        If fEmptyStr(edtDesEmpresa.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não cadastrada!', ['&Ok']);
          Result := FALSE;
        End
      End;
    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmFatBaixaClubeFidelidade.fGetSql(blnLike: Boolean): String;
  Var
    sqlSql: String;
Begin
  sqlSql := '';
  sqlSql := sqlSql + ' SELECT          ';
  sqlSql := sqlSql + '   F.AUTOINCREM, ';
  sqlSql := sqlSql + '   F.FID_CODFID, ';
  sqlSql := sqlSql + '   F.FID_CODEMP, ';
  sqlSql := sqlSql + '   F.FID_CREDEB, ';
  sqlSql := sqlSql + '   CONCAT(F.FID_NUMDOC,"-",F.FID_ESPDOC) AS DOCUMENTO, ';
  sqlSql := sqlSql + '   F.FID_QTDPTO, ';
  sqlSql := sqlSql + '   F.FID_DTACAD, ';

  If blnBaixa Then
    sqlSql := sqlSql + '   "N" AS MARCADO '
  Else
    sqlSql := sqlSql + '   "S" AS MARCADO ';

  sqlSql := sqlSql + ' FROM          ';
  sqlSql := sqlSql + '   CLUFID F   ';

  sqlSql := sqlSql + ' WHERE  ';

  If blnBaixa Then
  Begin
    sqlSql := sqlSql + '   F.FID_CODCLI = :CODCLI ';
    If (Not fEmptyStr(edtCodEmp.Text)) Then
      sqlSql := sqlSql + '  AND F.FID_CODEMP = :CODEMP ';

    If Not fEmptyDate(mskDtaIni.Text) Then
      sqlSql := sqlSql + ' AND F.FID_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

    sqlSql := sqlSql + '  AND F.FID_CODOPE IS NULL ';
  End
  Else
  Begin
    sqlSql := sqlSql + '   F.FID_CODCLI = :CODCLI ';
    sqlSql := sqlSql + ' AND F.FID_CODEMP = :CODEMP ';
    sqlSql := sqlSql + ' AND F.FID_CODFID = :CODFID ';
  End;

  Result := sqlSql;
End;

function TfrmFatBaixaClubeFidelidade.fSetParametros: Boolean;
Begin

  qryConsulta.ParamByName('CODCLI').AsString := edtCodCli.Text;

  If (Not fEmptyStr(edtCodEmp.Text)) Then
    qryConsulta.ParamByName('CODEMP').AsString := edtCodEmp.Text;

  If blnBaixa Then
  Begin
    If Not fEmptyDate(mskDtaIni.Text) Then
    Begin
      qryConsulta.ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      qryConsulta.ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
    End;
  End
  Else
  Begin
    qryConsulta.ParamByName('CODFID').AsString := strCodigo;
  End;


  Result := True;
End;

procedure TfrmFatBaixaClubeFidelidade.btnDesTodosClick(Sender: TObject);
  Var
    intRecNo: Integer;
begin
  If cdsConsulta.RecordCount <= 0 Then
    Exit;

  btnConfirma.Enabled := False;
  inherited;

  cdsConsulta.DisableControls;
  intRecNo := cdsConsulta.RecNo;

  cdsConsulta.First;
  While Not cdsConsulta.Eof Do
  Begin
    Application.ProcessMessages;
    cdsConsulta.Edit;
    cdsConsulta.FieldByName('MARCADO').AsString := 'N';
    cdsConsulta.Post;

    cdsConsulta.Next;
  End;

  cdsConsulta.RecNo := intRecNo;
  cdsConsulta.EnableControls;

  btnConfirma.Enabled := True;
end;


procedure TfrmFatBaixaClubeFidelidade.btnMarTodosClick(Sender: TObject);
  Var
    intRecNo: Integer;
begin
  If cdsConsulta.RecordCount <= 0 Then
    Exit;

  btnConfirma.Enabled := False;
  inherited;

  cdsConsulta.DisableControls;
  intRecNo := cdsConsulta.RecNo;

  cdsConsulta.First;
  While Not cdsConsulta.Eof Do
  Begin
    Application.ProcessMessages;
    cdsConsulta.Edit;
    cdsConsulta.FieldByName('MARCADO').AsString := 'S';
    cdsConsulta.Post;

    cdsConsulta.Next;
  End;

  cdsConsulta.RecNo := intRecNo;
  cdsConsulta.EnableControls;

  btnConfirma.Enabled := True;
end;

procedure TfrmFatBaixaClubeFidelidade.btnPesquisarClick(Sender: TObject);
begin
  If Not (cdsConsulta.IsEmpty) Then
    inherited;
end;

procedure TfrmFatBaixaClubeFidelidade.btnSairClick(Sender: TObject);
begin
  If fMensagem('', 'Deseja abandonar a tarefa?', ['&Sim', '&Não']) = 1 Then
  Begin
    pLimpaConsulta;
    Close;
  End;
end;

procedure TfrmFatBaixaClubeFidelidade.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  LastKey:=Key;

  Case Key Of
    VK_F6    : btnMarTodos.Click;
    VK_F7    : btnDesTodos.Click;
    VK_F10   : btnConfirma.Click;
    VK_RETURN: inherited;
    VK_ESCAPE: If cdsConsulta.State = dsEdit Then
                 cdsConsulta.Cancel
               Else
               Begin
                 If cdsConsulta.Active And (cdsConsulta.RecordCount > 0) Then
                 Begin
                   If fMensagem('', 'Deseja abandonar a tarefa?', ['&Sim', '&Não']) = 1 Then
                   Begin
                     pLimpaConsulta;
                   End;
                 End
                 Else
                 begin
                   inherited;
                   pnlHeader.Enabled := True;
                 end;
               End;
    VK_UP,
    VK_DOWN:   If cdsConsulta.State = dsEdit Then
               Begin
                 Key:=0;
                 cdsConsulta.Post;
                 Key:=LastKey;
               End
               Else
                 inherited;
    Else
      inherited;
  End;

end;

procedure TfrmFatBaixaClubeFidelidade.FormShow(Sender: TObject);
begin
  inherited;
  pLimpaPesquisa;
  If (Not blnBaixa) Then
  Begin
    edtCodCli.Text := strCliente;
    pCarregaCliente;
    edtCodEmp.Text := strEmpresa;
    pCarregaEmpresa;
    fAbreConsulta(False);
  End;
  edtCodCli.Enabled := blnBaixa;
  edtCodEmp.Enabled := blnBaixa;
  mskDtaIni.Enabled := blnBaixa;
  mskDtaFin.Enabled := blnBaixa;

  If edtCodCli.Enabled Then
   pSetFocus(edtCodCli);

end;

function TfrmFatBaixaClubeFidelidade.fAbreConsulta(blnLike: Boolean): Boolean;
Begin
  Result := inherited fAbreConsulta(blnLike);

  If cdsConsulta.Active Then
    cdsConsulta.LogChanges := False;

End;

procedure TfrmFatBaixaClubeFidelidade.dbgConsultaDblClick(Sender: TObject);
begin
  inherited;
  If cdsConsulta.RecordCount > 0 Then
  Begin
    If cdsConsulta.FieldByName('MARCADO').AsString = 'S' Then
    Begin
      cdsConsulta.Edit;
      cdsConsulta.FieldByName('MARCADO').AsString := 'N';
      cdsConsulta.Post;
    End
    Else If cdsConsulta.FieldByName('MARCADO').AsString = 'N' Then
    Begin
      cdsConsulta.Edit;
      cdsConsulta.FieldByName('MARCADO').AsString := 'S';
      cdsConsulta.Post;
    End;
  End;

end;

procedure TfrmFatBaixaClubeFidelidade.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  //inherited;

  If Column.Index = lflLastField.intIndCol then
  Begin
    dbgConsulta.Canvas.Brush.Color:= clInfoBk;
    dbgConsulta.Canvas.Font.Color:= clWindowText;
    dbgConsulta.Canvas.FillRect(Rect);
  End;

  If cdsConsulta.IsEmpty Then
    Exit;

  If cdsConsulta.FieldByName('MARCADO').AsString = 'S' Then
  Begin
    If dbgConsulta.Canvas.Brush.Color = clHighLight Then
      dbgConsulta.Canvas.Font.Color := clHighLightText
    Else
      dbgConsulta.Canvas.Font.Color := clBlue;
  End;


  dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmFatBaixaClubeFidelidade.dbgConsultaDrawDataCell(Sender: TObject;
  const Rect: TRect; Field: TField; State: TGridDrawState);
begin
  inherited;
  If cdsConsulta.IsEmpty Then
    Exit;

  If cdsConsulta.FieldByName('MARCADO').AsString = 'S' Then
  Begin
    If dbgConsulta.Canvas.Brush.Color = clHighLight Then
      dbgConsulta.Canvas.Font.Color := clHighLightText
    Else
      dbgConsulta.Canvas.Font.Color := clBlue;
  End;

dbgConsulta.DefaultDrawDataCell(Rect,Field,State);
end;

procedure TfrmFatBaixaClubeFidelidade.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
    fValidaCampos(edtCodCli, True);
end;

procedure TfrmFatBaixaClubeFidelidade.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmpresas: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmpresa, Nil, Key, arrEmpresas) Then
    fValidaCampos(edtCodEmp, True);
end;

procedure TfrmFatBaixaClubeFidelidade.FormCreate(Sender: TObject);
begin
  inherited;
  qryAuxiliar := fCriaQuery(Self);
  strCodigo  := '';
  strEmpresa := '';
  strCliente := '';
  blnBaixa   := True;

end;

procedure TfrmFatBaixaClubeFidelidade.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryAuxiliar);
  inherited;
end;

procedure TfrmFatBaixaClubeFidelidade.btnConfirmaClick(Sender: TObject);
  Var
    strSQL : String;
    qryUpdate : TUniQuery;
begin
  inherited;

  If cdsConsulta.IsEmpty Then
    Exit;


  qryUpdate := fCriaQuery;
  Try
    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  CLUFID ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  FID_DTABAI = :DTABAI, ';
    strSQL := strSQL + '  FID_HRABAI = :HRABAI, ';
    strSQL := strSQL + '  FID_CODOPE = :CODOPE ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  AUTOINCREM = :AUTOINCREM ';

    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add(strSQL);

    cdsConsulta.DisableControls;

    cdsConsulta.Filtered := False;
    cdsConsulta.Filter := 'MARCADO =''S''';
    cdsConsulta.Filtered := True;
    cdsConsulta.First;
    fStartTransaction;
    While (Not cdsConsulta.Eof) do
    Begin

      If blnBaixa Then
      Begin
        qryUpdate.ParamByName('DTABAI').AsDate := Date;
        qryUpdate.ParamByName('HRABAI').AsTime := fTime();
        qryUpdate.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

      End
      Else
      Begin
        qryUpdate.ParamByName('DTABAI').Value := Null;
        qryUpdate.ParamByName('HRABAI').Value := Null;
        qryUpdate.ParamByName('CODOPE').Value := Null;
      End;

      qryUpdate.ParamByName('AUTOINCREM').AsString := cdsConsulta.FieldByName('AUTOINCREM').ASString;
      qryUpdate.ExecSQL;

      cdsConsulta.Next;
    End;

    fCommit;
    cdsConsulta.Filtered := False;
    btnDesTodos.Click;
    cdsConsulta.EnableControls;

    pMensagemOk('Registros atualizados com sucesso!');
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[btnConfirmaClick]');
    End;
  End;

  FreeAndNil(qryUpdate);

  If blnBaixa Then
    fAbreConsulta(False)
  Else
    Close;

end;

//procedure TfrmFatBaixaClubeFidelidade.pInicializaTemporaria;
//begin
//  cdsVenda.EmptyDataSet;
//  pnlTail.Visible    := False;
//end;

procedure TfrmFatBaixaClubeFidelidade.pLimpaConsulta(idxRdg:Integer=0);
begin
  stlListSelecao.Clear;
  cdsConsulta.Close;
  pnlHeader.Enabled := True;
end;

end.
