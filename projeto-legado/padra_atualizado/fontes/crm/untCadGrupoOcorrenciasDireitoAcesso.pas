unit untCadGrupoOcorrenciasDireitoAcesso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass, Uni,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, untZClient,
  cxLookAndFeelPainters, cxProgressBar, cxContainer, cxEdit, cxCheckListBox, cxDBCheckListBox,
  Vcl.CheckLst;

type
  TOpcaoMarca = (opcMarcar, opcDesmarcar);

  TfrmCadGrupoOcorrenciasDireitoAcesso = class(TfrmPaiConfirma)
    pnlOperadores: TPanel;
    pnlBotoesOpe: TPanel;
    Splitter1: TSplitter;
    btnDesmarcaTodosOpe: TBitBtnLocked;
    btnMarcaTodosOpe: TBitBtnLocked;
    lblOpe: TLabel;
    lstOperador: TCheckListBox;
    pnlGrupo: TPanel;
    lblGrupo: TLabel;
    Panel2: TPanel;
    btnDesmarcaTodosGrp: TBitBtnLocked;
    btnMarcaTodosGrp: TBitBtnLocked;
    lstGrupos: TCheckListBox;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnMarcaTodosOpeClick(Sender: TObject);
    procedure btnDesmarcaTodosOpeClick(Sender: TObject);
    procedure btnMarcaTodosGrpClick(Sender: TObject);
    procedure btnDesmarcaTodosGrpClick(Sender: TObject);
  private
    FCodGoc   : String;

    function fCarregaRegistros(cxProgress : TcxProgressBar):Boolean;
    function fGravaRegistros(cxProgress : TcxProgressBar):Boolean;

    procedure pMarcar(stlList : TCheckListBox; opcMar : TOpcaoMarca);
  public
    Class procedure fDirAcesso(strCodGoc : String);
  Published
    Property strCodGoc : String Read FCodGoc;
  end;

implementation

{$R *.dfm}

uses untGravando, untHelperCitel, untFuncoesSimples;

procedure TfrmCadGrupoOcorrenciasDireitoAcesso.btnMarcaTodosGrpClick(Sender: TObject);
begin
  inherited;
  pMarcar(lstGrupos, opcMarcar);
end;

procedure TfrmCadGrupoOcorrenciasDireitoAcesso.btnDesmarcaTodosGrpClick(
  Sender: TObject);
begin
  inherited;
  pMarcar(lstGrupos, opcDesmarcar);
end;

procedure TfrmCadGrupoOcorrenciasDireitoAcesso.btnDesmarcaTodosOpeClick(
  Sender: TObject);
begin
  inherited;
  pMarcar(lstOperador, opcDesmarcar);
end;

procedure TfrmCadGrupoOcorrenciasDireitoAcesso.btnMarcaTodosOpeClick(
  Sender: TObject);
begin
  inherited;
  pMarcar(lstOperador, opcMarcar);
end;

function TfrmCadGrupoOcorrenciasDireitoAcesso.fCarregaRegistros(cxProgress: TcxProgressBar): Boolean;
  Var
    intIndex : Integer;
    cdsDirOpe : TZClient;
    cdsDirGpo : TZClient;
begin
  Try
    Try
      Result := True;
      lstOperador.Items.Clear;

      cdsDirOpe := TZClient.Create(Self);
      cdsDirGpo := TZClient.Create(Self);

      With cdsDirOpe, qryQuery.SQL Do
      Begin
        Close;
        Clear;

        Add(' SELECT GOO_CODOPE,                                  ');
        Add('        GOO_CODGOC,                                  ');
        Add('        CONCAT(OPE_CODOPE,"-", OPE_NOMOPE) AS NOMOPE ');
        Add(' FROM CADOPE                                         ');
        Add(' LEFT JOIN GOCOPE ON GOO_CODOPE = OPE_CODOPE         ');
        Add('                 AND GOO_CODGOC = :CODGOC            ');
        Add(' ORDER BY OPE_CODOPE                                 ');
        qryQuery.ParamByName('CODGOC').AsString := strCodGoc;
        fAbreClient(True);

      End;

      With cdsDirGpo, qryQuery.SQL Do
      Begin
        Close;
        Clear;

        Add(' SELECT GOG_CODGPO,                                  ');
        Add('        GOG_CODGOC,                                  ');
        Add('        CONCAT(GPO_CODGPO,"-", GPO_DESCRI) AS NOMGPO ');
        Add(' FROM CADGPO                                         ');
        Add(' LEFT JOIN GOCGPO ON GOG_CODGPO = GPO_CODGPO         ');
        Add('                 AND GOG_CODGOC = :CODGOG            ');
        Add(' ORDER BY GPO_CODGPO                                 ');
        qryQuery.ParamByName('CODGOG').AsString := strCodGoc;
        fAbreClient(True);

        cxProgress.pSetMax(RecordCount + cdsDirOpe.RecordCount);

        While Not Eof Do
        Begin
          intIndex := lstGrupos.Items.Add(FieldByName('NOMGPO').AsString);
          lstGrupos.Checked[intIndex] := not fEmptyStr(FieldByName('GOG_CODGPO').AsString);

          Next;
          cxProgress.pStep;
          Application.ProcessMessages;
        End;
      End;

      With cdsDirOpe, qryQuery.SQL Do
      Begin
        While Not Eof Do
        Begin
          intIndex := lstOperador.Items.Add(FieldByName('NOMOPE').AsString);
          lstOperador.Checked[intIndex] := not fEmptyStr(FieldByName('GOO_CODGOC').AsString);

          Next;
          cxProgress.pStep;
          Application.ProcessMessages;
        End;
      End;

      lstOperador.ItemIndex := 0;
      lstGrupos.ItemIndex := 0;
    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TfrmCadGrupoOcorrenciasDireitoAcesso.fCarregaRegistros');
      End;
    End;

  Finally
    FreeAndNil(cdsDirOpe);
    FreeAndNil(cdsDirGpo);
  End;

end;

class procedure TfrmCadGrupoOcorrenciasDireitoAcesso.fDirAcesso(strCodGoc: String);
  var
    frmForm : TfrmCadGrupoOcorrenciasDireitoAcesso;
begin
  Try
    pCriarFormularios(TfrmCadGrupoOcorrenciasDireitoAcesso, frmForm);
    frmForm.FCodGoc := strCodGoc;
    frmForm.ShowModal;
  Finally
    FreeAndNil(frmForm);
  End;
end;

function TfrmCadGrupoOcorrenciasDireitoAcesso.fGravaRegistros(cxProgress: TcxProgressBar): Boolean;
  Var
    qryAuxiliar : TUniQuery;
    intIndex    : Integer;
begin
  Try
    Result := True;
    cxProgress.pSetMax(lstOperador.Items.Count + lstGrupos.Items.Count);
    qryAuxiliar := fCriaQuery;
    Try
      fStartTransaction;
      With qryAuxiliar, SQL Do
      Begin
        Close;
        Clear;
        Add(' DELETE FROM GOCOPE WHERE GOO_CODGOC = :CODGOC ');
        ParamByName('CODGOC').AsString := strCodGoc;
        ExecSQL;

        Close;
        Clear;
        Add(' INSERT INTO GOCOPE(GOO_CODOPE, GOO_CODGOC) ');
        Add('             VALUES(:CODOPE, :CODGOC)       ');

        ParamByName('CODGOC').AsString := strCodGoc;

        For intIndex := 0 To lstOperador.Items.Count - 1 Do
        Begin
          If lstOperador.Checked[intIndex] Then
          Begin
            ParamByName('CODOPE').AsString := Copy(lstOperador.Items[intIndex], 1, 3);
            ExecSQL;
          End;

          cxProgress.pStep;
          Application.ProcessMessages;
        End;

        Close;
        Clear;
        Add(' DELETE FROM GOCGPO WHERE GOG_CODGOC = :CODGOC ');
        ParamByName('CODGOC').AsString := strCodGoc;
        ExecSQL;

        Close;
        Clear;
        Add(' INSERT INTO GOCGPO(GOG_CODGPO, GOG_CODGOC) ');
        Add('             VALUES(:CODGPO, :CODGOC)       ');

        ParamByName('CODGOC').AsString := strCodGoc;

        For intIndex := 0 To lstGrupos.Items.Count - 1 Do
        Begin
          If lstGrupos.Checked[intIndex] Then
          Begin
            ParamByName('CODGPO').AsInteger := StrToIntDef(Copy(lstGrupos.Items[intIndex], 1, Pos('-', lstGrupos.Items[intIndex])-1 ),-1);
            If ParamByName('CODGPO').AsInteger >= 0 Then
              ExecSQL;
          End;

          cxProgress.pStep;
          Application.ProcessMessages;
        End;

      End;

      fCommit;
    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TfrmCadGrupoOcorrenciasDireitoAcesso.fGravaRegistros');
      End;
    End;
  Finally
    FreeAndNil(qryAuxiliar);
  End;
end;

procedure TfrmCadGrupoOcorrenciasDireitoAcesso.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  inherited;

  If (ModalResult = MrOk) Then
  Begin
    If fMensagem('','Deseja Gravar os Direitos de Acesso?', ['&Sim', '&Não']) = 2 Then
    Begin
      Action := caNone;
      Exit;
    End;

    Try
      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.fExecutarAcao := fGravaRegistros;
      frmGravando.ShowModal;
    Finally
      FreeAndNil(frmGravando);
    End;
  End;

end;

procedure TfrmCadGrupoOcorrenciasDireitoAcesso.FormShow(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fCarregaRegistros;
    frmGravando.lblGravando.Caption := 'Aguarde, Carregando Direitos de Acesso...';
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;
end;

procedure TfrmCadGrupoOcorrenciasDireitoAcesso.pMarcar(stlList: TCheckListBox; opcMar: TOpcaoMarca);
  Var
    intIndex : Integer;
begin
  For intIndex := 0 To stlList.Items.Count -1 Do
  Begin
    Case opcMar Of
      opcMarcar    : stlList.Checked[intIndex] := True;
      opcDesmarcar : stlList.Checked[intIndex] := False;
    End;
  End;

end;

end.
