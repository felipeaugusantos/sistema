unit untCadVenMar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, untPaiOrdena, DB, Mask,
  DBClient, Provider, Uni, AppEvnts, Menus, StdCtrls, EditFocus,
  MaskEditFocus, Grids, DBGrids, Buttons, ExtCtrls, BitBtnLockedIncrem,DBCtrls, DBEditFocus,
  ComCtrls, UniClientDataSet, UniDataSetProvider, MemDS,
  DBAccess, frxClass, frxExportCSVTestabilidade, DBGridCitel, untConsultas, untTypesSistema;

type
  TfrmCadVenMar = class(TfrmPaiOrdena)
    Label1         : TLabel;
    edtCodVen      : TEditFocus;
    edtNomVen      : TEditFocus;
    pnlDados       : TPanel;
    btnGravar      : TBitBtnLocked;
    Label4         : TLabel;
    edtDesMar      : TEditFocus;
    edtCodMar      : TEditFocus;
    btnAdicionar   : TBitBtnLocked;
    btnCancelaItem : TBitBtnLocked;
    Label2         : TLabel;
    edtCodFor      : TEditFocus;
    edtNomFor      : TEditFocus;
    pgbProgresso   : TProgressBar;
    btnDelFor      : TBitBtnLocked;
    dbgVendedores: TDBGridCitel;
    dtsVendedores: TDataSource;
    rdbTodas: TRadioButton;
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMudaOrdemClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure btnDelForClick(Sender: TObject);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
  private
    arrSelVendedores: TConsultasArray;
    blnVariosVendedores: Boolean;
    qryVendedores: TUniQuery;
    strVendedores: string;
    intHeightForm: Integer;
    intTopForm: Integer;
    intHeightPnlHeader: Integer;

    procedure pCarregaMarcas;
    procedure pLimpaTela;
    procedure pLimpaDados;
    procedure pGravaDadosVendedor;

    procedure pExcluirFornecedor(strCodFor: String);

    procedure pInsereMarcas(strCodFor: String);
    procedure pRetFornecedoresPorMarca(Const strCodMar: String; Var stlCodFor: TStringList);
    procedure pCarregaVendedores;
    procedure pAfterScroll(Dataset: TDataset);
    procedure pAdicionaUnicaMarca(strCodFor : String);
    procedure pAdicionaVariasMarcas;
  protected
    { Protected declarations }
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; Override;
    function fGetSql(blnLike: Boolean): String; Override;
    procedure pEscapePressed; Override;
  public
    { Public declarations }
  end;

implementation

uses untPai,
     untFuncoesSimples, untDigFornecedor;

{$R *.dfm}

function TfrmCadVenMar.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If (Sender = edtCodVen) Then
    Begin
      strVendedores := '';
      blnVariosVendedores := (arrSelVendedores <> nil) and (Length(arrSelVendedores) > 1);
      if blnVariosVendedores then
        pCarregaVendedores
      else
      If fEmptyStr(edtCodVen.Text) Then
      Begin
        Result := False;
        fMensagem('','Digite o Código do Vendedor!', ['&Ok']);
      End

      Else
      Begin
        edtNomVen.Text := fRetNomeOperador(edtCodVen.Text);
        If fEmptyStr(edtNomVen.Text) Then
        Begin
          Result := False;
          fMensagem('','Código do Vendedor Inválido!', ['&Ok']);
        End;

        If Result Then
          pCarregaMarcas;

      End;

    End

    Else
    If (Sender = edtCodMar) Then
    Begin
      If fEmptyStr(edtCodMar.Text) Then
      Begin
        Result := False;
        fMensagem('', 'Digite o Código da Marca!', ['&Ok']);
      End
      Else
      Begin
        edtDesMar.Text := fRetNomeMarca(edtCodMar.Text);
        If fEmptyStr(edtDesMar.Text) Then
        Begin
          Result := False;
          fMensagem('', 'Código da Marca Inválido!', ['&Ok']);
        End;

      End;

    End

    Else
    If (Sender = edtCodFor) Then
    Begin
      If fEmptyStr(edtCodFor.Text) Then
      Begin
        edtNomFor.Clear;
      End

      Else
      Begin
        edtNomFor.Text := fRetNomFornecedor(edtCodFor.Text);
        If fEmptyStr(edtNomFor.Text) Then
        Begin
          Result := False;
          fMensagem('', 'Código do Fornecedor Inválido!', ['&Ok']);
        End;

      End;

    End;
    
  End;

  If Not Result Then
  Begin
    pSetFocus(Sender);
  End;
end;

function TfrmCadVenMar.fGetSql(blnLike: Boolean): String;
begin
  Result := '';
  Result := Result + ' SELECT                     ';
  Result := Result + '   VEM_CODVEN AS CODVEN,    ';
  Result := Result + '   VEM_CODMAR AS CODMAR,    ';
  Result := Result + '   MAR_DESMAR AS DESMAR,    ';
  Result := Result + '   VEM_CODFOR AS CODFOR,    ';
  Result := Result + '   FOR_NOMFOR AS NOMFOR,    ';
  Result := Result + '   VENMAR.AUTOINCREM AS AUTINC ';
  Result := Result + ' FROM        ';
  Result := Result + '   VENMAR    ';
  Result := Result + '   INNER JOIN CADMAR ON VEM_CODMAR = MAR_CODMAR ';
  Result := Result + '   LEFT JOIN CADFOR ON VEM_CODFOR = FOR_CODFOR ';
  Result := Result + ' WHERE       ';
  if blnVariosVendedores then
    Result := Result + '   VEM_CODVEN IN (' + strVendedores + ') '
  else
    Result := Result + '   VEM_CODVEN = ' + QuotedStr(edtCodVen.Text);

  lflLastField.strNomCam := 'DESMAR'
end;

procedure TfrmCadVenMar.pAfterScroll(Dataset: TDataset);
begin
  if (Assigned(DataSet)) and (Dataset.Active) and (Assigned(cdsConsulta)) and (cdsConsulta.Active) then
  begin
    cdsConsulta.Filtered := False;
    if (pnlPesquisa.Visible) and  (not fEmptyStr(cdsConsulta.Filter)) and (Pos(fGetFilter, cdsConsulta.Filter) > 0) then
      cdsConsulta.Filter := 'CODVEN = ' + QuotedStr(Dataset.FieldByName('OPE_CODOPE').AsString) + ' and ' + fGetFilter
    else
      cdsConsulta.Filter := 'CODVEN = ' + QuotedStr(Dataset.FieldByName('OPE_CODOPE').AsString);
    cdsConsulta.Filtered := True;
    if cdsConsulta.RecordCount > 1 then
      dbgConsulta.Width := dbgConsulta.Width + 1;
  end;
end;

procedure TfrmCadVenMar.pCarregaMarcas;
begin
  edtCodVen.Enabled  := False;
  pnlDados.Enabled   := True;
  btnGravar.Enabled  := True;
  blnMudarFoco       := False;
  fAbreConsulta(False);
  btnDelFor.Enabled  := (Not cdsConsulta.IsEmpty);
  pLimpaDados;
end;

procedure TfrmCadVenMar.pCarregaVendedores;
var
  intCont: Integer;
begin
  strVendedores := '';
  for intCont := Low(arrSelVendedores) to High(arrSelVendedores) do
  begin
    if not fEmptyStr(strVendedores) then
      strVendedores := strVendedores + ',';

    strVendedores := strVendedores + '"' + arrSelVendedores[intCont].strCodigo + '"';
  end;

  if (not Assigned(qryVendedores)) then
  begin
    qryVendedores := fCriaQuery();
    dtsVendedores.DataSet := qryVendedores;
    qryVendedores.AfterScroll := pAfterScroll;
  end;

  qryVendedores.Close;
  qryVendedores.SQL.Clear;
  qryVendedores.SQL.Add('SELECT ');
  qryVendedores.SQL.Add('  OPE_CODOPE, OPE_NOMOPE ');
  qryVendedores.SQL.Add('FROM ');
  qryVendedores.SQL.Add('  CADOPE ');
  qryVendedores.SQL.Add('WHERE ');
  qryVendedores.SQL.Add('  OPE_CODOPE IN (' + strVendedores + ') ');
  qryVendedores.Open;

  Self.Top         := intTopForm - 60;
  pnlHeader.Height := intHeightPnlHeader + 120;
  Self.Height      := intHeightForm + 120;

  pCarregaMarcas;

  pAfterScroll(qryVendedores);
end;

procedure TfrmCadVenMar.pLimpaDados;
var
  intCont : Integer;
begin
  For intCont := 0 To pnlDados.ControlCount -1 Do
  Begin
    If pnlDados.Controls[intCont] Is TEditFocus Then
    Begin
      TEditFocus(pnlDados.Controls[intCont]).Clear;
    End;
  End;

  cdsConsulta.Cancel;
  pSetFocus(edtCodMar);
end;

procedure TfrmCadVenMar.pLimpaTela;
begin
  cdsConsulta.Close;
  edtCodVen.Clear;
  edtNomVen.Clear;
  if Assigned(qryVendedores) then
    qryVendedores.Close;
  pnlHeader.Height := intHeightPnlHeader;
  Self.Height := intHeightForm;
  Self.Top := intTopForm;
  edtCodVen.Enabled  := True;
  pnlDados.Enabled   := False;
  btnGravar.Enabled  := False;
  btnDelFor.Enabled  := False;
  pLimpaDados;
  pLimpaPesquisa;
  pnlPesquisa.Visible := False;
  lflLastField.intIndCol := -1;
  pSetFocus(edtCodVen);
end;

procedure TfrmCadVenMar.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  pLimpaDados;
end;

procedure TfrmCadVenMar.pAdicionaUnicaMarca(strCodFor : String);
var
  intContVend: Integer;
  blnMarForJahInformados: Boolean;
  strCodVen: string;
  arrCodVen: Array of string;
  intRecNo: Integer;
  stlCodFor: TStringList;
  intIndex: Integer;
begin
  strCodVen := edtCodVen.Text;

  If fValidaPanel(pnlDados, False) Then
  Begin
    stlCodFor := TStringList.Create;

    Try

      If (Not fEmptyStr(strCodFor)) Then
        stlCodFor.Add(strCodFor)
      Else
        pRetFornecedoresPorMarca(edtCodMar.Text, stlCodFor);

      pgbProgresso.Max := stlCodFor.Count;
      pgbProgresso.Visible := True;

      For intIndex := 0 to PRed(stlCodFor.Count) do
      Begin
        strCodFor := stlCodFor[intIndex];

        if blnVariosVendedores then
        begin
          intRecNo := cdsConsulta.RecNo;
          cdsConsulta.DisableControls;
          cdsConsulta.Filtered := False;
          for intContVend := 0 to Length(arrSelVendedores) - 1 do
          begin
            blnMarForJahInformados := cdsConsulta.Locate('CODVEN;CODMAR;CODFOR', VarArrayOf([arrSelVendedores[intContVend].strCodigo,  edtCodMar.Text, strCodFor]), []);
            if not blnMarForJahInformados then
            begin
              SetLength(arrCodVen, Length(arrCodVen) + 1);
              arrCodVen[Length(arrCodVen) - 1] := arrSelVendedores[intContVend].strCodigo;
            end;
          end;
          blnMarForJahInformados := (Length(arrCodVen) = 0);
          cdsConsulta.Filtered := True;
          cdsConsulta.RecNo := intRecNo;
          cdsConsulta.EnableControls;
        end
        else
          blnMarForJahInformados := cdsConsulta.Locate('CODMAR;CODFOR', VarArrayOf([edtCodMar.Text, strCodFor]), []);

        If blnMarForJahInformados Then
        Begin
          fMensagem('', 'Esta marca e fornecedor já foram informados!', ['&OK']);
        End
        Else
        Begin
          cdsConsulta.Tag := 1;
          intContVend := 0;

          repeat
            if blnVariosVendedores then
            begin
              strCodVen := arrCodVen[intContVend];
              Inc(intContVend);
            end;

            cdsConsulta.Append;
            cdsConsulta.FieldByName('CODVEN').AsString := strCodVen;
            cdsConsulta.FieldByName('CODMAR').AsString := edtCodMar.Text;
            cdsConsulta.FieldByName('DESMAR').AsString := edtDesMar.Text;
            cdsConsulta.FieldByName('CODFOR').AsString := strCodFor;
            cdsConsulta.FieldByName('NOMFOR').AsString := fRetNomFornecedor(strCodFor);
            cdsConsulta.Post;

          until not (blnVariosVendedores and (intContVend < Length(arrCodVen)));

          cdsConsulta.Tag := 0;
        End;

        pgbProgresso.Position := intIndex + 1;
        Application.ProcessMessages;

      End;
    Finally
      pgbProgresso.Position := 0;
      pgbProgresso.Visible := False;

      FreeAndNil(stlCodFor);

      if blnVariosVendedores then
        pAfterScroll(qryVendedores)
      else
        pRefresh;

      pLimpaDados;
    End;

  End;

end;

procedure TfrmCadVenMar.pAdicionaVariasMarcas;
Var
  intContVend: Integer;
  blnMarForJahInformados: Boolean;
  strCodVen: string;
  arrCodVen: Array of string;
  intRecNo: Integer;
  qryMarcas : TUniQuery;
Begin
  strCodVen := edtCodVen.Text;
  qryMarcas := fCriaQuery(Nil);

  Try

    qryMarcas.SQL.Text := 'SELECT DISTINCT CM.MAR_CODMAR, CM.MAR_DESMAR, CI.ITE_CODFOR, CF.FOR_NOMFOR FROM CADMAR CM '+
                          'INNER JOIN CADITE CI ON CI.ITE_CODMAR = CM.MAR_CODMAR '+
                          'INNER JOIN CADFOR CF ON CF.FOR_CODFOR = CI.ITE_CODFOR '+
                          'WHERE CM.MAR_ATIVA_ = ''S'' AND CI.ITE_CODFOR IS NOT NULL';
    qryMarcas.Open;

    qryMarcas.First;
    cdsConsulta.DisableControls;
    pgbProgresso.Visible := True;
    pgbProgresso.Max     := qryMarcas.RecordCount;

    While Not qryMarcas.Eof Do
    Begin

      If blnVariosVendedores Then
      Begin
        intRecNo := cdsConsulta.RecNo;
         cdsConsulta.Filtered := False;
        For intContVend := 0 To Length(arrSelVendedores) - 1 Do
        Begin
          blnMarForJahInformados := cdsConsulta.Locate('CODVEN;CODMAR;CODFOR', VarArrayOf([arrSelVendedores[intContVend].strCodigo,
                                                                                           qryMarcas.FieldByName('MAR_CODMAR').AsString,
                                                                                           qryMarcas.FieldByName('ITE_CODFOR').AsString]), []);
          If Not blnMarForJahInformados Then
          Begin
            SetLength(arrCodVen, Length(arrCodVen) + 1);
            arrCodVen[Length(arrCodVen) - 1] := arrSelVendedores[intContVend].strCodigo;
          End;
        End;
        blnMarForJahInformados := (Length(arrCodVen) = 0);
        cdsConsulta.Filtered := True;
        cdsConsulta.RecNo := intRecNo;

      End
      Else
        blnMarForJahInformados := cdsConsulta.Locate('CODMAR;CODFOR', VarArrayOf([qryMarcas.FieldByName('MAR_CODMAR').AsString,
                                                                                  qryMarcas.FieldByName('ITE_CODFOR').AsString]), []);

      If blnMarForJahInformados Then
      Begin
        qryMarcas.Next;
        Continue;
      End
      Else
      Begin
        cdsConsulta.Tag := 1;
        intContVend := 0;

        Repeat
          If blnVariosVendedores Then
          Begin
            strCodVen := arrCodVen[intContVend];
            Inc(intContVend);
          End;

          cdsConsulta.Append;
          cdsConsulta.FieldByName('CODVEN').AsString := strCodVen;
          cdsConsulta.FieldByName('CODMAR').AsString := qryMarcas.FieldByName('MAR_CODMAR').AsString;
          cdsConsulta.FieldByName('DESMAR').AsString := qryMarcas.FieldByName('MAR_DESMAR').AsString;
          cdsConsulta.FieldByName('CODFOR').AsString := qryMarcas.FieldByName('ITE_CODFOR').AsString;
          cdsConsulta.FieldByName('NOMFOR').AsString := qryMarcas.FieldByName('FOR_NOMFOR').AsString;
          cdsConsulta.Post;

        Until Not (blnVariosVendedores And (intContVend < Length(arrCodVen)));

        cdsConsulta.Tag := 0;

        If blnVariosVendedores Then
          pAfterScroll(qryVendedores)
        Else
          pRefresh;

        pLimpaDados;
      End;

      pgbProgresso.Position := cdsConsulta.RecNo;
      Application.ProcessMessages;
      qryMarcas.Next;
    End;
  Finally
    cdsConsulta.EnableControls;
    pgbProgresso.Position := 0;
    pgbProgresso.Visible  := False;
    FreeAndNil(qryMarcas);
  End;
End;

procedure TfrmCadVenMar.btnAdicionarClick(Sender: TObject);
begin

  If (fEmptyStr(edtCodMar.Text) and (Not(rdbTodas.Checked))) Then
  Begin
    fMensagem('', 'Obrigatório Preenchimento da Marca!', ['&OK']);
    pSetFocus(edtCodMar);
    Exit;
  End;

  If (rdbTodas.Checked) Then
    pAdicionaVariasMarcas()
  Else
    pAdicionaUnicaMarca(edtCodFor.Text);

  inherited;
end;

procedure TfrmCadVenMar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  If (cdsConsulta.Active) And (cdsConsulta.RecordCount > 0) Then
  Begin
    Action := caNone;
    If fMensagem('', 'Deseja cancelar?', ['&Sim', '&Não'], 2) = 1 Then
      pLimpaTela;
  End
  else if Assigned(qryVendedores) then
    FreeAndNil(qryVendedores);
end;

procedure TfrmCadVenMar.FormCreate(Sender: TObject);
begin
  inherited;
  blnTemSelecao       := False;
  blnSempreRelerBanco := False;
  blnVariosVendedores := False;
  intTopForm := 0;
end;

procedure TfrmCadVenMar.dbgConsultaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  strCodMar: string;
  strCodFor: string;
  strInd: string;
begin
  inherited;
  Case Key Of
    VK_DELETE: If (Not cdsConsulta.IsEmpty) And
                  (fMensagem('','Deseja excluir esta marca?', ['&SIM','&NÃO']) = 1) Then
               Begin
                 if blnVariosVendedores then
                 begin
                   strCodMar := cdsConsulta.FieldByName('CODMAR').AsString;
                   strCodFor := cdsConsulta.FieldByName('CODFOR').AsString;
                   cdsConsulta.Filtered := False;
                   cdsConsulta.DisableControls;
                   strInd := cdsConsulta.IndexFieldNames;
                   cdsConsulta.IndexFieldNames := 'CODMAR;CODFOR';
                   cdsConsulta.FindKey([strCodMar, strCodFor]);
                 end;

                 repeat
                   cdsConsulta.Delete;

                 until not (blnVariosVendedores and ((cdsConsulta.FieldByName('CODMAR').AsString = strCodMar)
                                                and (cdsConsulta.FieldByName('CODFOR').AsString = strCodFor)));

                 if blnVariosVendedores then
                 begin
                   cdsConsulta.IndexFieldNames := strInd;
                   cdsConsulta.Filtered := True;
                   cdsConsulta.EnableControls;
                 end;
               End;
  End;
end;

procedure TfrmCadVenMar.FormShow(Sender: TObject);
begin
  inherited;

  SelectFirst;
end;

procedure TfrmCadVenMar.pEscapePressed;
begin
  If (Not pnlPesquisa.Visible) Then
  Begin
    If Assigned(ActiveControl) And (ActiveControl.Parent = pnlDados) Then
    Begin
      If fMensagem('', 'Deseja cancelar?', ['&Sim', '&Não'], 2) = 1 Then
        pLimpaTela;
    End
    Else If (dbgConsulta.Focused) Then
    Begin
      pLimpaDados;
    End
    Else
    Begin
      Inherited;
    End;
  End
  Else
  Begin
    Inherited;
  End;
end;

procedure TfrmCadVenMar.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = VK_ESCAPE Then
  Begin
    Key := 0;
    pEscapePressed;
    btnDelFor.Enabled  := (Not cdsConsulta.IsEmpty);
  End
  Else
  Begin
    inherited;
    if pnlPesquisa.Visible and blnVariosVendedores and
       (Key = VK_RETURN) and not blnSempreRelerBanco then
      pAfterScroll(qryVendedores);
  End;

  Case Key Of
    VK_F3 : begin
              pSetFocus(dbgConsulta);
              if blnVariosVendedores then
                pAfterScroll(qryVendedores);
            end;
    VK_F7 : Begin
              Key := 0;
              btnDelFor.Click;
            End;
    VK_F10: Begin
              Key := 0;
              btnGravar.Click;
            End;
  End;
end;

procedure TfrmCadVenMar.FormPaint(Sender: TObject);
begin
  inherited;

  if intTopForm = 0 then
  begin
    intTopForm         := Self.Top;
    intHeightForm      := Self.Height;
    intHeightPnlHeader := pnlHeader.Height;
  end;
end;

procedure TfrmCadVenMar.btnMudaOrdemClick(Sender: TObject);
begin
  inherited;
  if blnVariosVendedores then
    pAfterScroll(qryVendedores);
  pSetFocus(dbgConsulta);
end;

procedure TfrmCadVenMar.btnGravarClick(Sender: TObject);
begin
  inherited;
  If btnGravar.Enabled Then
  Begin
    pGravaDadosVendedor;
  End;
end;

procedure TfrmCadVenMar.pGravaDadosVendedor;
var
  qryVenMar : TUniQuery;

  procedure pSetParam(strCampo: String);
  begin
    If fEmptyStr(cdsConsulta.FieldByName(strCampo).AsString) Then
    Begin
      qryVenMar.ParamByName(strCampo).Value    := Null;
    End
    Else
    Begin
      qryVenMar.ParamByName(strCampo).AsString := cdsConsulta.FieldByName(strCampo).AsString;
    End;
  end;
begin
  qryVenMar       := fCriaQuery(Nil);
  pnlInfo.Caption := 'Aguarde, Gravando Arquivo...';
  Self.Enabled    := False;
  Try
    cdsConsulta.DisableControls;
    cdsConsulta.Filter   := '';
    cdsConsulta.Filtered := False;
    pgbProgresso.Visible := True;
    pgbProgresso.Max     := cdsConsulta.RecordCount;

    With qryVenMar Do
    Begin
      Try
        fStartTransaction;

        Close;
        SQL.Clear;
        if blnVariosVendedores then
        begin
          qryVenMar.SQL.Add(' DELETE FROM VENMAR WHERE VEM_CODVEN IN (' + strVendedores + ') ');
        end
        else
        begin
          SQL.Add(' DELETE FROM VENMAR WHERE VEM_CODVEN = :CODVEN ');
          ParamByName('CODVEN').AsString := edtCodVen.Text;
        end;
        ExecSQL;

        Close;
        SQL.Clear;
        SQL.Add(' INSERT INTO VENMAR (');
        SQL.Add('   VEM_CODVEN,       ');
        SQL.Add('   VEM_CODMAR,       ');
        SQL.Add('   VEM_CODFOR,       ');
        SQL.Add('   AUTOINCREM)       ');
        SQL.Add(' VALUES (            ');
        SQL.Add('   :CODVEN,          ');
        SQL.Add('   :CODMAR,          ');
        SQL.Add('   :CODFOR,          ');
        SQL.Add('   :AUTINC)          ');

        cdsConsulta.First;
        While Not cdsConsulta.Eof Do
        Begin
          pgbProgresso.Position := cdsConsulta.RecNo;
          Application.ProcessMessages;
          pSetParam('CODVEN');
          pSetParam('CODMAR');
          ParamByName('CODFOR').AsString := cdsConsulta.FieldByName('CODFOR').AsString;
          ParamByName('AUTINC').AsString := fRetAutoIncrem('VENMAR', VS_strCodEmp);
          ExecSQL;
          cdsConsulta.Next;
        End;

        fCommit;
        fMensagem('','Gravação efetuada com sucesso!',['&OK']);
      Except
        On E: Exception Do
        Begin
          fRollBack;
          pMensagensErro(E.Message, '[Ocorreu um erro ao tentar gravar os registros]');
        End;
      End;
    End;
  Finally
    FreeAndNil(qryVenMar);
    pgbProgresso.Position := 0;
    pgbProgresso.Visible  := False;
    cdsConsulta.EnableControls;
    pnlInfo.Caption       := '';
    Self.Enabled          := True;
    pLimpaTela;
  End;
end;

procedure TfrmCadVenMar.btnPesquisarClick(Sender: TObject);
begin
  If (Not cdsConsulta.Active) Or (cdsConsulta.RecordCount = 0) Then
  Begin
    fMensagem('', 'É necessário selecionar um vendedor para iniciar a busca!', ['&OK']);
  End
  Else
  Begin
    inherited;
  End;
end;

procedure TfrmCadVenMar.pInsereMarcas(strCodFor: String);
var
  qryTmp : TUniQuery;
  strInd : String;
  blnJahExisteRegistro: Boolean;
  intContVend: Integer;
  strCodVen: string;
begin
  If (cdsConsulta.Active) And((rdbTodas.Checked) Or
     (fMensagem('','Deseja Inserir Todas as Marcas do Fornecedor ' + strCodFor + '?', ['&SIM','&NÃO']) = 1)) Then
  Begin
    qryTmp := fCriaQuery(Self);
    Try
      With qryTmp Do
      Begin
        SQL.Clear;
        SQL.Add(' SELECT DISTINCT ITE_CODMAR ');
        SQL.Add('   FROM CADITE ');
        SQL.Add('  WHERE ITE_CODFOR = :CODFOR ');
        ParamByName('CODFOR').AsString := strCodFor;
        Open;

        strInd := cdsConsulta.IndexFieldNames;
        if blnVariosVendedores then
        begin
          cdsConsulta.DisableControls;
          cdsConsulta.Filtered := False;
          cdsConsulta.IndexFieldNames := 'CODVEN;CODMAR;CODFOR';
        end
        else
          cdsConsulta.IndexFieldNames := 'CODMAR;CODFOR';

        strCodVen := edtCodVen.Text;

        First;
        While Not Eof Do
        Begin
          intContVend := 0;

          repeat
            if blnVariosVendedores then
            begin
              strCodVen := arrSelVendedores[intContVend].strCodigo;
              Inc(intContVend);
              blnJahExisteRegistro := cdsConsulta.FindKey([strCodVen, qryTmp.FieldByName('ITE_CODMAR').AsString, strCodFor]);
            end
            else
              blnJahExisteRegistro := cdsConsulta.FindKey([FieldByName('ITE_CODMAR').AsString, strCodFor]);

            If not blnJahExisteRegistro Then
            Begin
              cdsConsulta.Tag := 1;

              cdsConsulta.Append;
              cdsConsulta.FieldByName('CODVEN').AsString := strCodVen;
              cdsConsulta.FieldByName('CODMAR').AsString := FieldByName('ITE_CODMAR').AsString;
              cdsConsulta.FieldByName('DESMAR').AsString := fRetNomMarca(FieldByName('ITE_CODMAR').AsString);
              cdsConsulta.FieldByName('CODFOR').AsString := strCodFor;
              cdsConsulta.FieldByName('NOMFOR').AsString := fRetNomFornecedor(strCodFor);
              cdsConsulta.Post;

              cdsConsulta.Tag := 0;
            End;
          until not (blnVariosVendedores and (intContVend < Length(arrSelVendedores)));
          Next;
        End;

        cdsConsulta.IndexFieldNames := strInd;

        if blnVariosVendedores then
        begin
          cdsConsulta.EnableControls;
          pAfterScroll(qryVendedores);
        end
        else
          pRefresh;

        pLimpaDados;
        Close;
      End;
    Finally
      FreeAndNil(qryTmp);
    End;
  End;
end;

procedure TfrmCadVenMar.edtCodForExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(edtCodFor.Text) Then
  Begin
    pInsereMarcas(edtCodFor.Text);
  End;
end;

procedure TfrmCadVenMar.edtCodForKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
    strWhere: String;
begin
  inherited;

  strWhere := '';
  If (Not fEmptyStr(edtCodMar.Text)) then
    strWhere := ' FOR_CODFOR IN (SELECT DISTINCT(ITE_CODFOR) ITE_CODFOR FROM CADITE WHERE ITE_CODMAR = "' + edtCodMar.Text + '") ';

  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrSel, True, Nil, strWhere) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadVenMar.edtCodMarKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadVenMar.edtCodVenKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  arrSelVendedores := nil;

  If fPesqOperador(Self, edtCodVen, edtNomVen, Nil, Key, arrSelVendedores, False) Then
  Begin
    If fValidaCampos(edtCodVen, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadVenMar.pRetFornecedoresPorMarca(Const strCodMar: String; Var stlCodFor: TStringList);
var
  qryTmp : TUniQuery;
begin
  qryTmp := fCriaQuery(Self);

  Try

    qryTmp.SQL.Clear;

    qryTmp.SQL.Add('  SELECT                              ');
    qryTmp.SQL.Add('    DISTINCT(ITE_CODFOR) ITE_CODFOR   ');
    qryTmp.SQL.Add('  FROM                                ');
    qryTmp.SQL.Add('    CADITE                            ');
    qryTmp.SQL.Add('  WHERE                               ');
    qryTmp.SQL.Add('    ITE_CODMAR = :CODMAR              ');
    qryTmp.SQL.Add('    AND IFNULL(ITE_CODFOR, "") <> ""  ');

    qryTmp.ParamByName('CODMAR').AsString := strCodMar;
    qryTmp.Open;

    qryTmp.First;
    While (Not qryTmp.Eof) Do
    Begin
      stlCodFor.Add(qryTmp.FieldByName('ITE_CODFOR').AsString);
      qryTmp.Next;
    End;
  Finally
    FreeAndNil(qryTmp);
  End;
end;

procedure TfrmCadVenMar.btnDelForClick(Sender: TObject);
var
  frmDigFornecedor: TfrmDigFornecedor;
begin
  inherited;
  pCriarFormularios(TfrmDigFornecedor, frmDigFornecedor);
  Try
    frmDigFornecedor.Caption := 'Digite o Código do Fornecedor';
    frmDigFornecedor.lblCliFor.Caption := 'Fornecedor';
    If (frmDigFornecedor.ShowModal = MrOK) Then
    Begin
      pExcluirFornecedor(frmDigFornecedor.edtCodFor.Text);
    End;
  Finally
    pFreeAndNil(frmDigFornecedor);
  End;
end;

procedure TfrmCadVenMar.pExcluirFornecedor(strCodFor: String);
var
  blnExcluiu : Boolean;
begin
  If Not fEmptyStr(strCodFor) Then
  Begin
    If (fMensagem('','Deseja excluir todas as marcas do fornecedor selecionado?', ['&Sim', '&Não']) = 1) Then
    Begin
      blnExcluiu := False;

      cdsConsulta.DisableControls;
      cdsConsulta.Filtered := False;
      cdsConsulta.First;
      While Not cdsConsulta.Eof Do
      Begin
        If cdsConsulta.FieldByName('CODFOR').AsString = strCodFor Then
        Begin
          cdsConsulta.Delete;
          blnExcluiu := True;
        End
        Else
        Begin
          cdsConsulta.Next;
        End;
      End;
      if blnVariosVendedores then
        cdsConsulta.Filtered := True;
      cdsConsulta.First;
      cdsConsulta.EnableControls;

      If Not blnExcluiu Then
      Begin
        fMensagem('','Não existem marcas para o fornecedor selecionado.', ['&OK']);
      End;
    End;
  End;
end;

end.
