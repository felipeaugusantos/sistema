unit untRelMapaDeContagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Vcl.Mask, MaskEditFocus, untTypesSistema;

type
  TfrmRelMapaDeCaontagem = class(TfrmPaiConfirma)
    Panel1: TPanel;
    Label8: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblDigita: TLabel;
    Label5: TLabel;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    edtLocIni: TEditFocus;
    edtLocFin: TEditFocus;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    edtSupEstFin: TEditFocus;
    edtSupEstIni: TEditFocus;
    edtCodDig: TEditFocus;
    edtNomDig: TEditFocus;
    edtCodMarca: TEditFocus;
    edtNomMarca: TEditFocus;
    rdgStatus: TRadioGroup;
    Label7: TLabel;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDigExit(Sender: TObject);
    procedure edtCodDigKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarcaExit(Sender: TObject);
    procedure edtCodMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtLocFinKeyPress(Sender: TObject; var Key: Char);
    procedure edtLocIniKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    arrLinhaGrupo,
    arrFornecedor,
    arrDigitador,
    arrDepto,
    arrMarca: TConsultasArray;

    blnCadLoc: Boolean;

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmRelMapaDeCaontagem: TfrmRelMapaDeCaontagem;

implementation

{$R *.dfm}

Uses
  untConsultas,
  untZClient,
  untFuncoesSimples,
  untFuncoesConsulta,
  untHistoricoBalanco,
  untDiferencaContagemGrid,
  untRelBalancoEstoqueDiferenca;

procedure TfrmRelMapaDeCaontagem.btnConfirmaClick(Sender: TObject);
  Var
    cdsGen : TZClient;
    objHistorico: THistoricoBalanco;
begin
  inherited;

  Try
    cdsGen := TZClient.Create(Self);

    If TfrmRelBalancoEstoqueDiferenca.fCarregaDiferencas(cdsGen,
                                                         True,
                                                         mskLinhaGrupo,
                                                         edtLocIni,
                                                         edtLocFin,
                                                         edtSupEstIni,
                                                         edtSupEstFin,
                                                         edtCodFor,
                                                         edtCodDig,
                                                         edtCodDep,
                                                         edtCodMarca,
                                                         arrLinhaGrupo,
                                                         arrFornecedor,
                                                         arrDigitador,
                                                         arrDepto,
                                                         arrMarca,
                                                         rdgStatus,
                                                         Nil,
                                                         Nil,
                                                         Nil,
                                                         Nil) Then
    Begin

      objHistorico := THistoricoBalanco.Create(Self);

      If objHistorico.fMontaMapaDiferenca(cdsGen) Then
      Begin

        pCriarFormularios(TfrmDiferencaContagemGrid, frmDiferencaContagemGrid);
        frmDiferencaContagemGrid.objHistorico := objHistorico;
        frmDiferencaContagemGrid.ShowModal;
        pFreeAndNil(frmDiferencaContagemGrid);

      End;

      FreeAndNil(objHistorico);
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmRelMapaDeCaontagem.btnConfirmaClick]');
    End;
  End;

end;

procedure TfrmRelMapaDeCaontagem.edtCodDepExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodDep,edtDesdep, arrDepto,fRetNomDep,nil,'do Departamento');
end;

procedure TfrmRelMapaDeCaontagem.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  if fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrDepto, False) then
  begin
    if fValidaCampos(edtCodDep, True) then
      Self.SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmRelMapaDeCaontagem.edtCodDigExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodDig, edtNomDig, arrDigitador, fRetNomeOperador, nil, 'do Operador');

end;

procedure TfrmRelMapaDeCaontagem.edtCodDigKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqOperador(Self, edtCodDig, edtNomDig, nil, Key, arrDigitador, False) then
  Begin
    If fValidaCampos(edtCodDig, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelMapaDeCaontagem.edtCodForExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodFor,edtNomFor,arrFornecedor,fRetNomFornecedor,nil,'do Fornecedor');

end;

procedure TfrmRelMapaDeCaontagem.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, nil, Key, arrFornecedor, False) Then
  Begin
    If fvalidaCampos(edtCodFor,False) Then
      self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelMapaDeCaontagem.edtCodMarcaExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodMarca,edtNomMarca, arrMarca,fRetNomMarca,nil,'da Marca');
end;

procedure TfrmRelMapaDeCaontagem.edtCodMarcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  if fPesqMarcas(Self, edtCodMarca, edtNomMarca, Nil, Key, arrMarca, False) then
  begin
    if fValidaCampos(edtCodMarca, True) then
      Self.SelectNext(ActiveControl, True, True);
  end;

end;

procedure TfrmRelMapaDeCaontagem.edtLocFinKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If blnCadLoc Then
    If fPesqLocFisica(Self, edtLocFin, Nil, Nil, Key, arrSel) Then
       If fValidaCampos(edtLocFin, True) Then
         SelectNext(ActiveControl, True, True);
end;

procedure TfrmRelMapaDeCaontagem.edtLocIniKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If blnCadLoc Then
    If fPesqLocFisica(Self, edtLocIni, Nil, Nil, Key, arrSel) And
     fValidaCampos(edtLocIni, True) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmRelMapaDeCaontagem.FormCreate(Sender: TObject);
begin
  inherited;

  blnCadLoc  := fCfgSis('CADLOC', varBoolean);
end;

procedure TfrmRelMapaDeCaontagem.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(mskLinhaGrupo,edtDesGrupo,arrLinhaGrupo,fRetNomeLinhaGrupo,Nil,'da linha/grupo',6);
end;

procedure TfrmRelMapaDeCaontagem.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrLinhaGrupo, False) Then
  Begin
    If fvalidaCampos(mskLinhaGrupo,False) Then
      self.SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmRelMapaDeCaontagem.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;

  Try

    If (inherited fValidaCampos(Sender)) Then
    Begin

      If (Sender = edtLocIni) Then
      Begin

        If blnCadLoc Then
        Begin

          If (Not fEmptyStr(edtLocIni.Text)) Then
          Begin

            If fEmptyStr(fRetNomLocFisica(edtLocIni.Text)) Then
            Begin
              pMensagemOk('Localização Física inicial não encontrada!');
              Result := False;
            End

          End;

        End;

      End

      Else If (Sender = edtLocFin) Then
      Begin

        If blnCadLoc Then
        Begin

          If (Not fEmptyStr(edtLocFin.Text)) Then
          Begin

            If fEmptyStr(fRetNomLocFisica(edtLocFin.Text)) Then
            Begin
              pMensagemOk('Localização Física final não encontrada!');
              Result := False;
            End

          End;

        End;

      End

    End;

  Except
    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmRelBalancoEstoqueDiferenca.fValidaCampos]');
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.
