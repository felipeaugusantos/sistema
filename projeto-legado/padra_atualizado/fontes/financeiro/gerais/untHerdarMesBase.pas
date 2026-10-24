unit untHerdarMesBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxCurrencyEdit,
  CurrencyEditFocus, EditFocus, Vcl.Mask, MaskEditFocus, Uni, Data.DB;

type
  TfrmHerdarMesBase = class(TfrmPai)
    btnConfirmar: TBitBtnLocked;
    PanelPrincipal: TPanel;
    gpbOrigem: TGroupBox;
    labelEmpOrig: TLabel;
    labelMesOrig: TLabel;
    edtCodEmpOrig: TEditFocus;
    edtDesEmpOrig: TEditFocus;
    gpbDestino: TGroupBox;
    labelMesDest: TLabel;
    labelEmpDest: TLabel;
    edtCodEmpDest: TEditFocus;
    edtDesEmpDest: TEditFocus;
    mskMesOrig: TMaskEditFocus;
    mskMesDest: TMaskEditFocus;
    edtTipMovOrig: TEditFocus;
    edtTipMovDest: TEditFocus;
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    function fExisteMesBase(dtaMesBase: tdateTime; sEmpresa, sTipo: string): boolean;
    function fValidaMes(strMes: string): boolean;
    { Private declarations }
  public
    { Public declarations }
    bolValidaMesmaEmpresa: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untFuncoesSimples;

{$R *.dfm}


{ TfrmHerdarMesBase }

procedure TfrmHerdarMesBase.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  if not fValidacampos(edtCodEmpOrig, True) Then
    Exit;
  if not fValidacampos(mskMesOrig, True) Then
    Exit;
  if not fValidacampos(edtCodEmpDest, True) Then
    Exit;
  if not fValidacampos(mskMesDest, True) Then
    Exit;

  If bolValidaMesmaEmpresa Then
  Begin
    If edtCodEmpOrig.Text <> edtCodEmpDest.Text Then
    Begin
      fMensagem('ATENÇÃO','As Empresas de Origem e Destino devem ser iguais!',['&Ok']);
      pSetFocus(edtCodEmpOrig);
      Exit;
    End;
  End;

  if fExisteMesBase(StrToDate('01/'+ mskmesDest.text),edtCodEmpDest.text,edtTipMovDest.text) then
  begin
    If fMensagem('', 'Já existe um mês base cadastrado para a empresa ' + edtCodEmpDest.Text +
                     '-' + edtDesEmpDest.Text + ' do mês ' + mskMesDest.Text +
                     '. Deseja sobrescreve-lo?', ['&Sim', '&Não']) = 2  Then
    begin
      exit;
    end;
  end;

  ModalResult := mrOk;

end;

function TfrmHerdarMesBase.fExisteMesBase(dtaMesBase: tdateTime; sEmpresa, sTipo: string): boolean;
var
  qryAuxSQL: TUniQuery;
begin
  qryAuxSQL := fCriaQuery;
  qryAuxSQL.sql.clear;
  qryAuxSQL.sql.text :=   'SELECT   '
                        + '  PAG_VALLAN, '
                        + '  PAG_AUTCTP  '
                        + 'FROM     '
                        + '  CTRPAG '
                        + 'WHERE    '
                        //+ '   PAG_CODFUN = :CODFUN AND '
                        //+ '   PAG_CODVER = :CODVER AND '
                        + '     PAG_CODEMP = :CODEMP     '
                        + ' AND PAG_MESBAS = :MESBAS     '
                        + ' AND PAG_TIPMOV = :TIPMOV     ';

  qryAuxSQL.parambyname('MESBAS').asdate   := dtaMesBase;
  qryAuxSQL.parambyname('CODEMP').asstring := sEmpresa;
  qryAuxSQL.parambyname('TIPMOV').asstring := sTipo;
  qryAuxSQL.open;

  result := not qryAuxSQL.isEmpty;
end;

procedure TfrmHerdarMesBase.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10: btnConfirmar.Click;
  End;
end;

function TfrmHerdarMesBase.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskMesOrig) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskMesOrig.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informar o mês de origem desejado!', ['&O k']);
        Result := False;
        pSetFocus(mskMesOrig);
      End
      Else If (Not fValidaMes((mskMesOrig.Text))) or (Length(Trim(fTiraCaracEspeciais(mskMesOrig.Text))) < 4) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe um mês de origem válido!', ['&O K']);
        Result := False;
        pSetFocus(mskMesOrig);
      End;
    End
    Else If (Sender = mskMesDest) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskMesDest.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informar o mês de destino desejado!', ['&O k']);
        Result := False;
        pSetFocus(mskMesDest);
      End
      Else If (Not fValidaMes((mskMesDest.Text))) or (Length(Trim(fTiraCaracEspeciais(mskMesDest.Text))) < 4) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe um mês de destino válido!', ['&O K']);
        Result := False;
        pSetFocus(mskMesDest);
      End;
    End
    Else If (Sender = edtCodEmpOrig) Then
    Begin

      If fEmptyStr(edtCodEmpOrig.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Empresa Origem deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If Pos(edtCodEmpOrig.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          edtDesEmpOrig.Text := fRetNomeEmpresaSelec(edtCodEmpOrig.Text);
          If fEmptyStr(edtDesEmpOrig.Text) Then
          Begin
            fMensagem('ATENÇÃO!','Essa empresa não está cadastrada!',['&O K']);
            Result := False;
          End;
        End;
      End;

    End
    Else If (Sender = edtCodEmpDest) Then
    Begin

      If fEmptyStr(edtCodEmpDest.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Empresa Destino deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If Pos(edtCodEmpOrig.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          edtDesEmpDest.Text := fRetNomeEmpresaSelec(edtCodEmpDest.Text);
          If fEmptyStr(edtDesEmpDest.Text) Then
          Begin
            fMensagem('','Essa empresa não está cadastrada!',['&O K']);
            Result := False;
          End;
        End;
      End;

    End
    Else If (sender = edtTipMovOrig) then
    begin
      if not fExisteMesBase(StrToDate('01/'+ mskmesorig.text),edtCodEmpOrig.text,edtTipMovOrig.text) then
      begin
        fMensagem('ATENÇÃO!', 'Mês base origem não cadastrado!', ['&O K']);
        Result := False;
        pSetFocus(edtTipMovOrig);
      end;
    end;

    If Not Result Then
      pSetFocus(Sender);

  End;
end;

function TfrmHerdarMesBase.fValidaMes(strMes: string): boolean;
VAR
  strData: String;
begin
  Try
    strData := ('01/'+ strMes);

   If (StrToDateDef(strData, 0) <= 0) then
     Result := False
   else
    Result := True;
  Except
    Result := False;
  End;
end;

end.
