unit untCadNovaEntregaRegiaoAuto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem, Uni,
  ExtCtrls, EditFocus, Mask, MaskEditFocus, DateUtils, ComCtrls, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmCadNovaEntregaRegiaoAuto = class(TfrmPai)
    pnlGeral: TPanel;
    Label6: TLabel;
    Label1: TLabel;
    mskDtaIni: TMaskEditFocus;
    edtCodReg: TEditFocus;
    edtDesReg: TEditFocus;
    Label2: TLabel;
    mskDtaFin: TMaskEditFocus;
    btnConfirmar: TBitBtnLocked;
    pgbProgresso: TProgressBar;
    procedure btnSairClick(Sender: TObject);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
    ArrDatas: Array Of TDate;

    procedure pLimpaTela;
    procedure pPreencheArrayDatasIntervalo(qryReg: TUniQuery);

    function fGravaNovaEntregaAutomatica: Boolean;
    function fRetIntervalo(qryReg: TUniQuery): Integer;
//    function fChaveDuplicada: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;    
  public
    { Public declarations }
    blnConfirma: Boolean;    
  end;


implementation
uses
     untConsultas, untFuncoesSimples, untTypesSistema;

{$R *.dfm}

{ TfrmCadNovaEntregaRegiaoAuto }

procedure TfrmCadNovaEntregaRegiaoAuto.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos  Then
    blnConfirma := fGravaNovaEntregaAutomatica;

  If blnConfirma Then
    Self.Close;
end;

procedure TfrmCadNovaEntregaRegiaoAuto.btnSairClick(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

procedure TfrmCadNovaEntregaRegiaoAuto.edtCodRegKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrRegiao   : TConsultasArray;
begin
  inherited;
  If fPesqRotasRegiao(Self, edtCodReg, Nil, Nil, Key, arrRegiao) Then
		fValidaCampos(edtCodReg, False);
end;

{function TfrmCadNovaEntregaRegiaoAuto.fChaveDuplicada: Boolean;
  function fRetSQLSEL: String;
  Begin
    Result := '';
    Result := Result + ' SELECT ROT_CODREG ';
    Result := Result + '   FROM ROTREG ';
    Result := Result + '  WHERE ROT_CODEMP = :CODEMP ';
    If Not fEmptyStr(edtCodReg.Text) Then
      Result := Result + '  ANT ROT_CODREG = :CODREG ';
  End;
var
  qryCons: TZQuery;
  qrySel: TZQuery;
  intCont: Integer;
begin
  pPreencheArrayDatasIntervalo;

  Result := True;
  Try
    qryCons := fCriaQuery(Nil);
    qrySel := fCriaQuery(Nil);

    With qrySel Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fRetSQLSEL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      If Not fEmptyStr(edtCodReg.Text) Then
        ParamByName('CODREG').AsString := edtCodReg.Text;
      Open;
    End;

    With qryCons Do
    Begin
      qrySel.First;
      While Not qrySel.Eof Do
      Begin
        For intCont := 0 To Length(ArrDatas) Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(' SELECT COUNT(*) AS QTDE ');
          SQL.Add('   FROM ENTREG ');
          SQL.Add('  WHERE ENT_CODREG = :CODREG ');
          SQL.Add('    AND ENT_CODEMP = :CODEMP ');
          SQL.Add('    AND ENT_DTAENT = :DTAENT ');
          ParamByName('CODREG').AsString := FieldByName('ROT_CODREG').AsString;
          ParamByName('CODEMP').AsString := VS_strCodEmp;
          ParamByName('DTAENT').AsDate   := ArrDatas[intCont];
          Open;

          Result := FieldByName('QTDE').AsInteger > 0;

          If Result Then
            Break;
        End;
        qrySel.Next
      End;
    End;
  Finally
    FreeAndNil(qryCons);
    FreeAndNil(qrySel);
  End;
end;
}

function TfrmCadNovaEntregaRegiaoAuto.fGravaNovaEntregaAutomatica: Boolean;
  procedure pStep(pgbProgresso: TProgressBar);
  begin
    If Assigned(pgbProgresso) Then
    Begin
      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;
  end;

  function fRetSQLSEL: String;
  Begin
    Result := '';
    Result := Result + ' SELECT ROT_CODREG ';
    Result := Result + '   FROM ROTREG ';
    Result := Result + '  WHERE TRUE ';

    If fCfgSis('ROTEMP', varBoolean) Then
      Result := Result + '  AND ROT_CODEMP = :CODEMP ';

    If Not fEmptyStr(edtCodReg.Text) Then
      Result := Result + '  AND ROT_CODREG = :CODREG ';
  End;

  function fRetSQL: String;
  Begin
    Result := '';
    Result := Result + ' INSERT INTO ENTREG ( ';
    Result := Result + '        ENT_CODIGO,   ';
    Result := Result + '        ENT_CODEMP,   ';
    Result := Result + '        ENT_DTAENT,   ';
    Result := Result + '        ENT_CODREG,   ';
    Result := Result + '        ENT_ROTVEI,   ';
    Result := Result + '        ENT_STATUS,   ';
    Result := Result + '        AUTOINCREM  ) ';
    Result := Result + '            VALUES  ( ';
    Result := Result + '           :CODIGO,   ';
    Result := Result + '           :CODEMP,   ';
    Result := Result + '           :DTAENT,   ';
    Result := Result + '           :CODREG,   ';
    Result := Result + '           :ROTVEI,   ';
    Result := Result + '           :STATUS,   ';
    Result := Result + '           :AUTOIN  ) ';
  End;
var
  qryIns: TUniQuery;
  qrySel: TUniQuery;
  intCont: Integer;
begin
  Result := True;
  Try
    qryIns := fCriaQuery(Nil);
    qrySel := fCriaQuery(Nil);
    Try

      With qrySel Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fRetSQLSEL);
        If fCfgSis('ROTEMP', varBoolean) Then
          ParamByName('CODEMP').AsString := VS_strCodEmp;
        If Not fEmptyStr(edtCodReg.Text) Then
          ParamByName('CODREG').AsString := edtCodReg.Text;
        Open;

        If IsEmpty Then
        Begin
          pMensagemOk('Nenhuma rota encontrada!');
          Exit;
        End;
      End;

      fStartTransaction;

      pgbProgresso.Position := 0;
      pgbProgresso.Max := qrySel.RecordCount;

      qrySel.First;
      While Not qrySel.Eof Do
      Begin

        pStep(pgbProgresso);

        pPreencheArrayDatasIntervalo(qrySel);

        For intCont := 0 To Length(ArrDatas) - 1 Do
        Begin
          If ArrDatas[intCont] > 0 Then
          Begin
            With qryIns Do
            Begin
              Close;
              SQL.Clear;
              SQL.Add(fRetSQL);
              ParamByName('CODIGO').AsString := fAtualizaProCod('ENTREG', 'ENT_CODIGO');
              ParamByName('CODEMP').AsString := VS_strCodEmp;
              ParamByName('DTAENT').AsDate   := ArrDatas[intCont];
              ParamByName('CODREG').AsString := qrySel.FieldByName('ROT_CODREG').AsString;
              ParamByName('ROTVEI').AsString := fRetVeiculoPadraoRotasRegiao(qrySel.FieldByName('ROT_CODREG').AsString);
              ParamByName('STATUS').AsString := 'A'; // ABERTO
              ParamByName('AUTOIN').AsString := fRetAutoIncrem('ENTREG', VS_strCodEmp);
              ExecSql;
            End;
          End;
        End;

        qrySel.Next;
      End;

      fCommit;
      fMensagem('INFORMAÇÃO','Entregas automáticas cadastradas com sucesso !',['&Ok']);
      pLimpaTela;

    Except
      On E: Exception Do
      Begin
        fRollBack;
        Result := False;
        pMensagensErro(E.Message, '[fGravaNovaEntrega]');
      End;
    End;
  Finally
    FreeAndNil(qryIns);
    FreeAndNil(qrySel);
  End;
end;

procedure TfrmCadNovaEntregaRegiaoAuto.FormShow(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  pSetFocus(mskDtaIni);
end;

function TfrmCadNovaEntregaRegiaoAuto.fRetIntervalo(qryReg: TUniQuery): Integer;
var
  qryCons: TUniQuery;
begin
  Try
    qryCons := fCriaQuery(Nil);
    With qryCons Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT ROT_INTERV ');
      SQL.Add('   FROM ROTREG ');
      SQL.Add('  WHERE ROT_CODREG = :CODREG ');
      ParamByName('CODREG').AsString := qryReg.FieldByName('ROT_CODREG').AsString;
      Open;

      Result := FieldByName('ROT_INTERV').AsInteger;
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

function TfrmCadNovaEntregaRegiaoAuto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  
  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin
      If ((fEmptyStr(mskDtaIni.Text)) OR (mskDtaIni.Text = '  /  /    ')) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else If StrToDate(mskDtaIni.Text) < VS_Date Then
      Begin
        fMensagem('ATENÇÃO!', 'A data de entrega deve ser maior ou igual a hoje !', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = mskDtaFin) Then
    Begin

      If ((Not fEmptyStr(mskDtaIni.Text)) And (mskDtaIni.Text <> '  /  /    ')) And
         ((Not fEmptyStr(mskDtaFin.Text)) And (mskDtaFin.Text <> '  /  /    ')) And
         (StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text))  Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Inicial não pode ser maior que a data final!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If ((fEmptyStr(mskDtaFin.Text)) OR (mskDtaFin.Text = '  /  /    ')) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodReg) Then
    Begin
      If (fEmptyStr(edtCodReg.Text)) Then
      Begin
        edtDesReg.Text := 'TODAS';
      End
      Else
      Begin
        edtDesReg.Text := fRetNomRotasRegiao(edtCodReg.Text, True);
        If (fEmptyStr(edtDesReg.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa região não está cadastrada no cadastro de rotas ou ' + #13#10 +
                                'O Intervalo do cadastro da rota está zerado, ' + #13#10 +
                                'precisa ser maior que zero para gerar automaticamente !', ['&Ok']);
          Result := False;
        End;
      End;
    End;
    
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadNovaEntregaRegiaoAuto.pLimpaTela;
begin
  mskDtaIni.Clear;
  mskDtaFin.Clear;
  edtCodReg.Clear;
  edtDesReg.Clear;
end;

procedure TfrmCadNovaEntregaRegiaoAuto.pPreencheArrayDatasIntervalo(qryReg: TUniQuery);
Var
  intCont: Integer;
  dtaDtaIni: TDate;
  dtaDtaFin: TDate;
  intInterv: Integer;
Begin
  SetLength(ArrDatas,1);
  dtaDtaIni := StrToDate(mskDtaIni.Text);
  dtaDtaFin := StrToDate(mskDtaFin.Text);

  intInterv := fRetIntervalo(qryReg);

  intCont := 0;

  While Not (dtaDtaIni > dtaDtaFin) Do
  Begin
    If intCont = 0 Then
      ArrDatas[intCont] := dtaDtaIni
    Else
      Begin
        dtaDtaIni := dtaDtaIni + intInterv;
        If Not (dtaDtaIni > dtaDtaFin) Then
        Begin
          If DayOfWeek(dtaDtaIni) = 1 Then //Domingo
            dtaDtaIni := dtaDtaIni + 1;

          ArrDatas[intCont] := dtaDtaIni;
        End
        Else
          Exit;
      End;

    inc(intCont);
    SetLength(ArrDatas,intCont+1);
  End;
end;

end.
