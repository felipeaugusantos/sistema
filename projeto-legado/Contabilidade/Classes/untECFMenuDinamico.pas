unit untECFMenuDinamico;

interface

uses Classes, Forms, System.SysUtils, StrUtils, Vcl.Menus, Windows, AdvMenus,
     Data.DB, Uni, Vcl.Controls;

type
  TECFMenuTipo = (emtBloco, emtRegistro);

type
  TECFMenuDinamico = Class(TComponent)
  private
    FDono: TComponent ;
    FqryRegistro: TUniQuery ;
    FqryBloco: TUniQuery ;
    FMnuPrin: TAdvMainMenu;
    function fAdicionarMenu(intId: integer; strCaption: string; tpTipo: TECFMenuTipo; mnPai: TMenuItem):TMenuItem;
    procedure pProcedimento(Sender: TObject);
    function fGetCaption(strEcf, strDescricao: string;tpTipo: TECFMenuTipo):string ;
    procedure pCriaFormECF(Caption: TCaption; intId: integer);
  public
    procedure pCarregarParametrosECF;
    constructor Create(AOwner: TComponent; mnuPrincip: TAdvMainMenu); reintroduce;
    destructor Destroy; override;
  end;

implementation

uses untFuncoesSimples, Contabilidade.View.ParametrosECF ;

{ TECFMenuDinamico }

constructor TECFMenuDinamico.Create(AOwner: TComponent;
  mnuPrincip: TAdvMainMenu);
begin
  inherited Create(AOwner);
  FDono := AOwner ;
  FMnuPrin := mnuPrincip ;
  FqryRegistro := fCriaQuery ;
  FqryBloco := fCriaQuery ;
end;

destructor TECFMenuDinamico.Destroy;
begin
  FreeAndNil(FqryRegistro);
  FreeAndNil(FqryBloco);
  inherited;
end;

function TECFMenuDinamico.fAdicionarMenu(intId: integer; strCaption: string; tpTipo: TECFMenuTipo; mnPai: TMenuItem):TMenuItem;
var
  mnuBase : TMenuItem ;
  mnuECF  : TMenuItem ;
  strRB   : string ;
begin
  result := Nil ;

  if tpTipo = emtBloco then
  begin
    strRB := 'B' ;
  end
  else //emtRegistro
  begin
    strRB := 'R' ;
  end;

  if Assigned(mnPai) then
  begin
    mnuBase := mnPai ;
  end
  else
  begin
    mnuBase := TMenuItem(FDono.FindComponent('mnuECF')) ;
  end;

  if not Assigned(mnuBase) then
  begin
    exit ;
  end;

  mnuECF := TMenuItem.Create(FMnuPrin) ;
  mnuECF.Caption := strCaption ;
  mnuECF.Hint := '0_mnuEcf' + strRB + inttostr(intId) ;
  mnuECF.Name := 'mnuEcf' + strRB + inttostr(intId) ;
  mnuECF.Tag := intId ;
  if tpTipo = emtRegistro then
    mnuECF.OnClick := pProcedimento;
  mnuBase.Add(mnuECF);

  result := mnuECF ;

end;

function TECFMenuDinamico.fGetCaption(strEcf, strDescricao: string;
  tpTipo: TECFMenuTipo): string;
var
  strPrefixo : string ;
begin
  if tpTipo = emtBloco then
  begin
    strPrefixo := 'Bloco' ;
  end
  else //emtRegistro
  begin
    strPrefixo := 'Registro' ;
  end;
  result := strPrefixo + ' ' + strEcf + ' - ' + strDescricao ;
end;

procedure TECFMenuDinamico.pCarregarParametrosECF;
var
  strSql : string ;
  MenItemBloco : TMenuItem ;
  strCaption : string ;
begin
  if not fTabelaExiste('ECFBLC') then
    exit;

  if not fTabelaExiste('ECFREG') then
    exit;

  ////bloco
  strSql := '' ;
  strSql := strSql + ' SELECT AUTOINCREM, BLC_BLCECF, BLC_DESCRI ' ;
  strSql := strSql + ' FROM ECFBLC ' ;
  strSql := strSql + ' ORDER BY BLC_BLCECF ' ;

  FqryBloco.Close ;
  FqryBloco.SQL.Clear ;
  FqryBloco.SQL.Add(strSql) ;
  FqryBloco.Open ;

  /////registro
  strSql := '' ;
  strSql := strSql + ' SELECT AUTOINCREM, REG_BLCECF, REG_REGECF, REG_DESCRI ' ;
  strSql := strSql + ' FROM ECFREG ' ;
  strSql := strSql + ' ORDER BY REG_BLCECF, REG_REGECF ' ;

  FqryRegistro.Close ;
  FqryRegistro.SQL.Clear ;
  FqryRegistro.SQL.Add(strSql) ;
  FqryRegistro.Open ;

  FqryRegistro.DisableControls ;
  FqryBloco.DisableControls ;
  try
    FqryBloco.First ;
    while not FqryBloco.Eof do
    begin
      if FqryRegistro.Locate('REG_BLCECF', FqryBloco.FieldByName('BLC_BLCECF').AsString, [loCaseInsensitive]) then
      begin
        ////cria o menu do bloco ECF
        strCaption := fGetCaption(FqryBloco.FieldByName('BLC_BLCECF').AsString, FqryBloco.FieldByName('BLC_DESCRI').AsString, emtBloco) ;
        MenItemBloco := fAdicionarMenu(FqryBloco.FieldByName('AUTOINCREM').AsInteger, strCaption, emtBloco, Nil) ;

        ////cria os registros ECF
        while (FqryBloco.FieldByName('BLC_BLCECF').AsString = FqryRegistro.FieldByName('REG_BLCECF').AsString) and
              (not FqryRegistro.Eof) do
        begin
          strCaption := fGetCaption(FqryRegistro.FieldByName('REG_REGECF').AsString, FqryRegistro.FieldByName('REG_DESCRI').AsString, emtRegistro) ;
          fAdicionarMenu(FqryRegistro.FieldByName('AUTOINCREM').AsInteger, strCaption, emtRegistro, MenItemBloco) ;
          FqryRegistro.Next ;
        end;

      end;
      FqryBloco.Next ;
    end;
  finally
    FqryRegistro.EnableControls ;
    FqryBloco.EnableControls ;
  end;

end;

procedure TECFMenuDinamico.pProcedimento(Sender: TObject);
begin
  pCriaFormECF(TMenuItem(Sender).Caption, TMenuItem(Sender).Tag);
end;

procedure TECFMenuDinamico.pCriaFormECF(Caption: TCaption; intId: integer);
var
  frmParametrosECF : TfrmParametrosECF ;
begin
  Try
    pCriarFormularios(TfrmParametrosECF, frmParametrosECF);
    frmParametrosECF.IdParametrosECF := intId ;
    frmParametrosECF.Caption := StripHotkey(Caption);
    frmParametrosECF.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '['+StripHotkey(Caption)+']');
    End;
  End;
  pFreeAndNil(frmParametrosECF);
end;

end.
