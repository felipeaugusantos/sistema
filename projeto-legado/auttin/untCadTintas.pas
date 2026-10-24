unit untCadTintas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls,  untICadastroTinta, DB,
  Uni, Mask, DBCtrls, Math, BitBtnLockedIncrem,
  StrUtils, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadTintas = class(TfrmPaiCad)
    pnlCampos: TPanel;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
  private
    cadastro: ICadastroTinta;
  protected
    qryCadastro: TUniQuery;
    dtsCadastro: TDataSource;
    procedure pCriarDataSets; virtual;
    procedure pLigarDataSets; overload; virtual;
    procedure pLigarDataSets(dbeEdit: TDBEdit; lblLabel: TLabel; strNomeCampo: String; dbeCheckBox: TDBCheckBox = nil); overload; virtual;
    procedure pInicializaIndices; override;
    function fGetLarguraEdit(strNomeCampo: String): Integer; 
    procedure pSetaCamposChaves;
    function fGetDbEditByFieldName(strNomeCampo: String): TDBEdit;
    procedure pConsultaItemKeyPress(Sender: TObject; var Key: Char; strFilter : String = '');
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pCarregaItem; virtual; abstract;
    procedure pDesabilitaCamposChaves();
    function fInComponents(Componente: TComponent; Componentes: Array Of TComponent): Boolean;
    procedure pHabilitarTabs(blnHabilita: Boolean);
    procedure pConfigurarLabels; virtual; abstract;
    procedure pSetaEnableReadOnly(DataSet: TDataSet); virtual;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; cadastro: ICadastroTinta); reintroduce; virtual;
    { Public declarations }
  end;

var
  frmCadTintas: TfrmCadTintas;

implementation

uses untPai, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmPaiCadTintas }

constructor TfrmCadTintas.Create(AOwner: TComponent;
  cadastro: ICadastroTinta);
begin
  Self.cadastro := cadastro;
  inherited Create(AOwner);

  strNomeTabela := cadastro.fGetNomeTabela;
  fInsereProCod(strNomeTabela);
  strNomeCampo := cadastro.fGetNomeCampo;

  pnlNomeForm.Caption := cadastro.fGetNomeClasse;
  pHabilitarTabs(False);
end;

function TfrmCadTintas.fGetDbEditByFieldName(
  strNomeCampo: String): TDBEdit;
  Var
    intCont: Integer;
begin
  Result := Nil;
  
  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] Is TDBEdit) Then
      If (TDBEdit(Components[intCont]).DataField = strNomeCampo) Then
      Begin
        Result := TDBEdit(Components[intCont]);
        Exit;
      End;
  End;
end;

function TfrmCadTintas.fInComponents(Componente: TComponent; Componentes: Array Of TComponent): Boolean;
  Var
    intCont: Integer;
begin
  Result := False;
  
  For intCont := 0 To Length(Componentes) Do
  Begin
    Result := (Componente = Componentes[intCont]);
    If Result Then
    Begin
      Exit;
    End;
  End;
end;

function TfrmCadTintas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strRetorno: String;  
begin
  Result := True;

  If qryCadastro.State in [dsEdit, dsInsert] Then
  Begin
    Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

    If Result then
    Begin
      If (Sender Is TDBEdit) Then
        Result := cadastro.fValidaCampos(TDBEdit(Sender).DataField, TDBEdit(Sender).Text, strRetorno);

      If Result And (Sender = arrCamposChave[cadastro.fGetCountCamposChave - 1])
                And (blnBuscaPorChave) Then
      Begin
        If (Not fBuscaPorCamposChave) Then
        Begin
          pLimparCampos;
        End
        Else
        Begin
          pCarregaItem;
        End;

        pSetFocus(Sender);
      End;
    End;
  End;

  If Not Result Then
  Begin
    fMensagem('ATENÇÃO', strRetorno, ['OK']);
    pSetFocus(Sender);
  End;
end;

procedure TfrmCadTintas.pConsultaItemKeyPress(Sender: TObject; var Key: Char; strFilter : String = '');
  Var
    arrSel: TConsultasArray;
begin
  If fPesqItem(conIteSimples
              , Self
              , TDBEdit(Sender)
              , NIL
              , nil
              , Key
              , arrSel
              , True
              , Nil
              , ''
              , '1'
              , ''
              , 0
              , False
              , False
              , 0
              , cdrCodIte
              , ''
              , False
              , ''
              , True
              , False
              , True
              , ''
              , False
              , False
              , False
              , False
              , False
              , False
              , False
              , False
              , ''
              , -1
              , False
              , ''
              , True
              , strFilter) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadTintas.pCriarDataSets;
begin
  qryCadastro := fCriarQuery('SELECT * FROM ' + cadastro.fGetNomeTabela(), Self);
  dtsCadastro := fCriaDataSource(qryCadastro);

  qryTabela := qryCadastro;

  qryCadastro.AfterInsert := pSetaEnableReadOnly;
  qryCadastro.AfterEdit := pSetaEnableReadOnly;
  qryCadastro.AfterPost := pSetaEnableReadOnly;
  qryCadastro.AfterDelete := pSetaEnableReadOnly;
  qryCadastro.AfterOpen := pSetaEnableReadOnly;
//  qryCadastro.AfterClose := pSetaEnableReadOnly;
  qryCadastro.AfterRefresh := pSetaEnableReadOnly;
  qryCadastro.AfterScroll := pSetaEnableReadOnly;
end;

procedure TfrmCadTintas.pDesabilitaCamposChaves;
  Var
    intCont: Integer;
begin
  For intCont := 0 To Length(arrCamposChave) - 1 Do
  Begin
    if Assigned(arrCamposChave[intCont]) then
      arrCamposChave[intCont].Enabled := False;
  End;
end;

procedure TfrmCadTintas.pHabilitarTabs(blnHabilita: Boolean);
  Var
    intCont: Integer;
begin
  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] Is TDBEdit) Then
      TDBEdit(Components[intCont]).TabStop := blnHabilita;
  End;
end;

procedure TfrmCadTintas.pInicializaIndices;
begin
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Text := cadastro.fGetConsulta().fGetTodosCamposIndices();
  stlCamInd.Text := cadastro.fGetConsulta().fGetTodosCamposIndices();
  stlDesInd.Text := cadastro.fGetConsulta().fGetTodosDesCamposIndices();
end;

procedure TfrmCadTintas.pLigarDataSets;
  Var
    intCont: Integer;
begin
  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] Is TDBEdit) Then
    begin
      TDBEdit(Components[intCont]).DataSource := dtsCadastro;
      TDBEdit(Components[intCont]).CharCase   := ecUpperCase;
    end
    Else If (Components[intCont] Is TDBCheckBox) Then
      TDBCheckBox(Components[intCont]).DataSource := dtsCadastro
    Else If (Components[intCont] Is TDBComboBox) Then
      TDBComboBox(Components[intCont]).DataSource := dtsCadastro;
  End;
end;

procedure TfrmCadTintas.pSetaCamposChaves;
  Var
    intCont: Integer;
    dbeCampo: TDBEdit;
begin
  SetLength(arrCamposChave, cadastro.fGetCountCamposChave);
  For intCont := 0 To cadastro.fGetCountCamposChave - 1 Do
  Begin
    dbeCampo := fGetDbEditByFieldName(cadastro.fGetCampoChave(intCont));

    If Assigned(dbeCampo) Then
      arrCamposChave[intCont] := dbeCampo;
  End;


end;

procedure TfrmCadTintas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  pHabilitarTabs(True);
end;

procedure TfrmCadTintas.btnGravarClick(Sender: TObject);
begin
  inherited;
  pHabilitarTabs(False);
end;

procedure TfrmCadTintas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitarTabs(True);
end;

procedure TfrmCadTintas.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pHabilitarTabs(False);
end;

procedure TfrmCadTintas.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pHabilitarTabs(False);
end;

procedure TfrmCadTintas.btnPesquisaClick(Sender: TObject);
begin
  inherited;
  pHabilitarTabs(False);
end;

procedure TfrmCadTintas.pSetaEnableReadOnly(DataSet: TDataSet);
  Var
    blnCondicao: Boolean;
    blnCondicaoInsert: Boolean;
    blnEnabled: Boolean;
    intCont: Integer;
begin
  Try
    Try
      qryCadastro.DisableControls;
      blnCondicao := qryCadastro.State = dsEdit;
      blnCondicaoInsert := blnCondicao Or (qryCadastro.State = dsInsert);
      blnEnabled := ((qryCadastro.Active) And (qryCadastro.RecordCount > 0)) Or (blnCondicaoInsert);

      For intCont := 0 To ComponentCount - 1 Do
      Begin
        If Components[intCont] Is TDBEdit Then
        Begin
          TDBEdit(Components[intCont]).Enabled := blnEnabled;
          TDBEdit(Components[intCont]).ReadOnly := Not blnCondicaoInsert;

          if blnCondicao then
          begin
            if MatchStr(TDBEdit(Components[intCont]).DataField,
              ['COL_PESESP', 'BAS_PESESP', 'BAS_PESPEC', 'CAT_PESPEC',
              'DIL_PESPEC', 'DIL_DENSID', 'BAS_DENSID']) then
            begin
              TDBEdit(Components[intCont]).Enabled := False;
              TDBEdit(Components[intCont]).ReadOnly := True;
            end;
          end;

        End;
      End;
    Except
      on E: Exception do
      begin
        fMensagem('ATENÇÃO', Format('%s: %s', [E.ClassName, E.Message]), ['&Ok']);
      end;
    End;
  Finally
    qryCadastro.EnableControls;
  End;
end;

procedure TfrmCadTintas.pLigarDataSets(dbeEdit: TDBEdit; lblLabel: TLabel;
  strNomeCampo: String; dbeCheckBox: TDBCheckBox = nil);
begin

  If Assigned(dbeEdit) Then
  Begin
    dbeEdit.DataField := strNomeCampo;
    dbeEdit.Visible := Not fEmptyStr(strNomeCampo);
    dbeEdit.Tag := IfThen(dbeEdit.Visible, 99, 0);
  End;

  If Assigned(lblLabel) Then
  Begin
    lblLabel.Visible := Not fEmptyStr(strNomeCampo);
  End;

  If Assigned(dbeCheckBox) Then
  Begin
    dbeCheckBox.DataField := strNomeCampo;
    dbeCheckBox.Visible := Not fEmptyStr(strNomeCampo);
    dbeCheckBox.Tag := IfThen(dbeCheckBox.Visible, 99, 0);
  End;
end;

function TfrmCadTintas.fGetLarguraEdit(strNomeCampo: String): Integer;
begin
  Result := Canvas.TextWidth(fReplicatorStr('_', qryCadastro.FieldByName(strNomeCampo).Size)) + 20;
end;

end.
